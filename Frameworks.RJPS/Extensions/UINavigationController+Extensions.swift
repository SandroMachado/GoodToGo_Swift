//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 16/06/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import UIKit
import Foundation


extension UINavigationController
{
    func hideNavigationBarHidden()
    {
        self.navigationController?.navigationBarHidden = true;
    }
    /*
    override func presentViewController(viewController : UIViewController, addDismissToolbar:Bool) -> Void
    {
        if(HaveValue(viewController))
        {
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
    override func presentFrom(sender:UIViewController, addDismissToolbar:Bool) -> Void
    {
        if(HaveValue(sender))
        {
            sender.presentViewController(self, animated: true, completion: nil)
        }
    }*/
}


