//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{    
    
    // FIX: Hardcoded value
    func setNewImageWithSmootTransition(newImage:UIImage, duration:Double=0.3) -> Void {
        if(self.image==nil) {
            self.image = newImage
        }
        
        UIView.transitionWithView(self,
            duration: duration,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { self.image = newImage }) //set the new image
            { (Bool) -> Void in
               // self.animate() //Direct recursion
               // self.count++
        }
        /*
        UIView.animateWithDuration(duration/2.0,
            animations: {
                //  self.myView.alpha = 0
                self.alpha = 0
            },
            completion: { finished in
                // self.myView.removeFromSuperview()
            }
        )?*/
        
    }
}


