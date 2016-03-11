//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

import Whisper

struct RJSMessagesManager
{    
    static func showAlert(var sender sender: UIViewController?, title:String?, message : String) -> Void
    {
        // TODO : Colocar num utils
        if(!HaveValue(sender)) {
            if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                // topController should now be your topmost view controller
                sender = topController
            }
        }
        guard HaveValue(sender) else {
            DLogError("Fail to retried sender to present alert [\(ToString(message))]")
            return
        }
        RJSBlocks.executeInMainTread { () -> () in
            let messageToShow   = String.cleanString("\(message)")
            let alertController = UIAlertController(title: title, message:messageToShow, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            sender!.presentViewController(alertController, animated: true, completion: nil)
            //presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    static func showBigTopMessage(var title : String?, var subtitle : String?, sender:UIViewController?) -> Void {
        if((HaveValue(title) || HaveValue(subtitle)) && HaveValue(sender))
        {
            title    = String.cleanString(title!)
            subtitle = String.cleanString(subtitle!)

           // showAlert(sender: sender!, title: "Not implemented!", message: subtitle!)
            //let message = Message(title: "Enter your message here.", backgroundColor: UIColor.redColor())
            //Whisper(message, to: navigationController, action: .Present)
            
            //let announcement = Announcement(title: title!, subtitle: subtitle, image: UIImage(named: "avatar"))
            //Shout(announcement, to: sender!)
        }
        else
        {
            DLogWarning("Ignored...");
        }
    }
    
    static func showSmallTopMessage(message : String?) -> Void {
        if(!NSThread.isMainThread())
        {
            DLogWarning("Called from background? [\(ToString(message))]");
        }
        RJSBlocks.executeInMainTread { () -> () in
            if(HaveValue(message))
            {
                let murmur = Murmur(title: message!)
                Whistle(murmur)
            }
            else
            {
                DLogWarning("Ignored...");
            }
        }
    }
    
    static func showNoInternetConnetion(sender:UIViewController) -> Void {
        let message = "No internet connection!"
        
        // FIX: isVisible not working the rigth way
        
        // Avoid that diferent loaded viewcontrolleres can show the message
        if(sender.isVisible() || true) {
            RJSMessagesManager.showSmallTopMessage(message)
        } else {
            DLogWarning("Controller is not visible. The message [\(message)] as ignored")
        }
    }
    
}
