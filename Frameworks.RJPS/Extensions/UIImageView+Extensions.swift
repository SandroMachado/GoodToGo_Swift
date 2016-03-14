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
    
    func setNewImageWithSmootTransition(newImage:UIImage, duration:Double=1, ajustSize:Bool=true) -> Void {
        
        let arrangeSize = {
            guard ajustSize else {
                return
            }
            
            UIView.animateWithDuration(duration/2, animations: { () -> Void in
                let rate   = newImage.size.width / newImage.size.height
                if(rate>1) {
                    //DLog("Landscaped image")
                    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height/rate);
                    let dif = (self.frame.size.height - self.frame.size.height / rate) / 2
                    self.center = CGPointMake(self.center.x, self.center.y+dif)
                } else {
                    //DLog("Portrait image")
                    let dif     = (self.frame.size.width - self.frame.size.width * rate) / 2
                    self.center = CGPointMake(self.center.x + dif, self.center.y)
                    self.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width*rate, self.frame.size.height);
                }

                }, completion: { (Bool) -> Void in
                    
            })
        }
        
        UIView.transitionWithView(self,
            duration: duration/2,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: {
                self.image = newImage
            })
            { (Bool) -> Void in
                RJSBlocks.executeWithDelay(Tread.MainTread, delay: 0.1, block: {
                    arrangeSize()
                })
        }
    }
}


