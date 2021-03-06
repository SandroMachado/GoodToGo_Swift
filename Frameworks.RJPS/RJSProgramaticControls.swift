//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

struct  RJSProgramaticControls
{
    static func getUILabel(title:String?) -> UILabel
    {
        let label = UILabel()
        label.frame = CGRectMake(0, 0, 100, 45)
        label.numberOfLines = 0

        if(HaveValue(title))
        {
            label.text = title
        }
        else
        {
            label.text = "I made a label on the screen #toogood4you"
        }
        
        label.textAlignment = .Center
        label.numberOfLines = 0

        return label;
    }
    
    static func getUIButton(title:String?, backgroundColor:UIColor?, target:AnyObject?, action: Selector) -> UIButton
    {
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        if(HaveValue(backgroundColor))
        {
            button.backgroundColor = backgroundColor
        }
        else
        {
            button.backgroundColor = UIColor.greenColor()
        }
        
        if(!String.isNullOrEmpty(title))
        {
            button.setTitle(title, forState: UIControlState.Normal)
        }
        else
        {
            button.setTitle("Button", forState: UIControlState.Normal)
        }
        button.addTarget(target, action:action, forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    static func getUIBarButtonItem(title:String?, image:String?, backgroundColor:UIColor?, target:AnyObject?, action: Selector) -> UIBarButtonItem
    {
        
        let button  = UIButton(type: .Custom)
        
        if(HaveValue(image))
        {
            button.frame = CGRectMake(0, 0, 22, 22)
            if let image = UIImage(named: image!)
            {
                button.setImage(image, forState: .Normal)
            }
            else
            {
                DLogWarning("Image \(image) not found")
            }
        }
        if(!String.isNullOrEmpty(title))
        {
            button.frame = CGRectMake(0, 0, 30, 64)
            button.setTitle(title, forState: UIControlState.Normal)
            button.autoresizesSubviews = true;
        }
        button.addTarget(target, action:action, forControlEvents: UIControlEvents.TouchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    static func getUIBarButtonItem(target:AnyObject?) -> UIBarButtonItem
    {
        let result = RJSProgramaticControls.getUIBarButtonItem("Back", image:nil, backgroundColor:nil,target:target,action:Selector(UIViewController.btnDismissPressedSelector()))
        return result
    }
    
    static func getUIBarButtonFlexibleSpace() ->UIBarButtonItem
    {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    }

}
