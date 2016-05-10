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
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let button:UIButton = UIButton(frame: CGRectMake(btnX, btnY, btnWidth, btnHeight))
        
        button.backgroundColor = UIColor.greenColor()
        
        button.setTitle("Load Images", forState: UIControlState.Normal)
        
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.tag = 1;
        
        self.view.addSubview(button)
        
    }
    
    
    
    func buttonPressed(sender:UIButton!) {
        
        let btnsendtag:UIButton = sender
        
        if btnsendtag.tag == 1 {
            
            print("Button pressed")
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    
}