//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    

    func isVisible() -> Bool
    {
/*
        if (((self.isViewLoaded() && self.view.window) != nil) != nil)
        {
            return true;
        }
        else
        {
            return false;
        }
*/
        return false;

    }
    
    func presentViewController(viewController : UIViewController, addDismissToolbar:Bool) -> Void
    {
        if(HaveValue(viewController))
        {
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
    func presentFrom(sender:UIViewController, addDismissToolbar:Bool) -> Void
    {
        if(HaveValue(sender))
        {
            sender.presentViewController(self, animated: true, completion: nil)
        }
    }
    
    static func btnDismissPressedSelector () -> String
    {
        return "btnDismissPressed:"
    }
    
    @IBAction func btnDismissPressed(sender : AnyObject?) -> Void
    {
        self.dismissViewController(nil);
    }

    func dismissViewController(sender : AnyObject?) -> Void
    {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    /*
    @IBAction func btnDismissViewControllerWasPressed() -> Void
    {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
*/
    
}