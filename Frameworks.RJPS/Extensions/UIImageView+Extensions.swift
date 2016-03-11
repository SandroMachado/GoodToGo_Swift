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
    
    func setNewImageWithSmootTransition(newImage:UIImage, duration:Double=1) -> Void {
        
        if(self.image==nil) {
            // No image? Just set and leave
            self.image = newImage
            return
        }
        
        UIView.transitionWithView(self,
            duration: duration,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { self.image = newImage }) //set the new image
            { (Bool) -> Void in

        }
    }
}


