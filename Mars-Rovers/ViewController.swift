//
//  ViewController.swift
//  Mars-Rovers
//
//  Created by LaboratoriOS Cronian Academy on 10/05/16.
//  Copyright © 2016 LaboratoriOS Cronian Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    let btnX: CGFloat = 230
    let btnY: CGFloat = 40
    let btnWidth: CGFloat = 170
    let btnHeight: CGFloat = 35
    
    let txtX: CGFloat = 5
    let txtY: CGFloat = 40
    let txtWidth: CGFloat = 170
    let txtHeight: CGFloat = 35
    
    let button:UIButton = UIButton()
    let textField: UITextField = UITextField()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addButtonAndTextField()
    }
    
    
    
    func addButtonAndTextField(){
        textField.frame = CGRectMake(txtX, txtY, txtWidth, txtHeight)
        textField.backgroundColor = UIColor.whiteColor()
        textField.placeholder = "Enter a earth_date"
        textField.borderStyle = UITextBorderStyle.Line
        
        self.view.addSubview(textField)
        
        button.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight)
        button.backgroundColor = UIColor.blackColor()
        button.setTitle("Load Images", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        button.tag = 1;
        
        self.view.addSubview(button)
    }
    
    
    
    func buttonPressed(sender:UIButton!) {
        
        let btnsendtag:UIButton = sender
        
        if btnsendtag.tag == 1 {
            
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            
            addButtonAndTextField()
            
            print("Button pressed")
            
            let earth_date = textField.text!//"2016-4-23"
            let api_key = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
            let url = NSURL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(earth_date)&api_key=\(api_key)")!
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                        
                        if let objects = jsonResult["photos"]!{
                            
                            for i in 0..<objects.count{
                                //print(i)
                                //print(objects[i])
                                
                                let urlString = objects[i]["img_src"] as! String
                                
                                let imageView =  UIImageView()
                                let urlObj = NSURL(string: urlString)
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                                    let data = NSData(contentsOfURL: urlObj!)
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        
                                        let photoWidth: CGFloat = 100
                                        let photoHeight: CGFloat = 100
                                        let labelWidth: CGFloat = 200
                                        let labelHeight: CGFloat = 40
                                        let blockHeight = photoHeight + photoHeight
                                        
                                        
                                        imageView.image = UIImage(data: data!)
                                        imageView.frame = CGRect(x: 10, y: CGFloat(i+1) * blockHeight - photoHeight, width: photoWidth, height: photoHeight)
                                        
                                        let label = UILabel(frame: CGRectMake(10, 0, labelWidth, labelHeight))
                                        label.center = CGPointMake(labelWidth/2, CGFloat(i+1) * blockHeight + labelHeight/2)
                                        let photoId = objects[i]["id"] as! Int
                                        let labelText = "PhotoId = \(photoId)"
                                        label.text = labelText
                                        
                                        self.view.addSubview(label)
                                        self.view.addSubview(imageView)
                                    });
                                    
                                    
                                }
                            }
                            
                        }
                        
                    } catch {
                        print("JSON serialization failed")
                    }
                    
                }
                
            }
            task.resume()
        }   
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
}