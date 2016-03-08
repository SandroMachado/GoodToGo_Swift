//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public enum UIViewContants {
        static var defaultAnimationsTime: Double {
            return 0.3
        }
    }
    
    func fadeInTo(value: CGFloat, var duration:Double, delay:Double) -> Void
    {
        if(duration<=0)
        {
            duration = UIViewContants.defaultAnimationsTime
        }
        NSTimer.schedule(repeatInterval: delay) { timer in
            UIView.animateWithDuration(duration, animations: {
                self.alpha = value;
            })
        }
    }
    
    func fadeOutTo(value: CGFloat, var duration:Double, delay:Double) -> Void
    {
        if(duration<=0)
        {
            duration = UIViewContants.defaultAnimationsTime
        }
        NSTimer.schedule(repeatInterval: delay) { timer in
            UIView.animateWithDuration(duration, animations: {
                self.alpha = value;
            })
        }
    }
    
    func fadeOutAndInAgain(outValue: CGFloat, var duration:Double)
    {
        if(duration<=0)
        {
            duration = UIViewContants.defaultAnimationsTime
        }
        self.fadeOutTo(outValue, duration: duration/2, delay: 0)
        NSTimer.schedule(repeatInterval: duration/2) { timer in
            self.fadeInTo(1, duration: duration/2, delay: 0)
        }
    }

    func moveTo(point point:CGPoint, spring:Bool, duration:Double, delay:Double)
    {
        if(spring)
        {
            UIView.animateWithDuration(duration, delay: 0.0+delay, usingSpringWithDamping: 0.46, initialSpringVelocity: 0.1, options: [], animations: {
                self.center = point
                }, completion: nil)
        }
        else
        {
            UIView.animateWithDuration(UIViewContants.defaultAnimationsTime, animations: {
                self.center = point
            })
        }
    }

    func bump()
    {
        self.bump(size:3)
    }
    
    func bump(size size:CGFloat, duration:Double=UIViewContants.defaultAnimationsTime) -> Void
    {
        UIView.animateWithDuration(duration/2,
            animations: {
                self.frame = CGRectMake(self.frame.origin.x-size,
                    self.frame.origin.y-size,
                    self.frame.size.width+2*size,
                    self.frame.size.height+2*size);
            },
            completion: { finished in
                UIView.animateWithDuration(duration/2,
                    animations: {
                        self.frame = CGRectMake(self.frame.origin.x+size,
                            self.frame.origin.y+size,
                            self.frame.size.width-2*size,
                            self.frame.size.height-2*size);
                    },
                    completion: { finished in
                        // self.myView.removeFromSuperview()
                    }
                )}
        )
    }
    
    
    func rotate(degrees: CGFloat)
    {
        self.rotate(degrees: degrees)
    }
    
    func rotate(degrees degrees: CGFloat, duration: NSTimeInterval = UIViewContants.defaultAnimationsTime)->Void
    {
        UIView.animateWithDuration(duration, animations: {
            self.transform = CGAffineTransformMakeRotation((CGFloat(degrees) * CGFloat(M_PI)) / 180)
        })
    }
    
    func setCornerRadius(cornerSize: Int)
    {
        if(cornerSize>0)
        {
            self.layer.cornerRadius = CGFloat(cornerSize);
            self.clipsToBounds      = true;
        }
    }
    
    func animate () -> Void
    {
        UIView.animateWithDuration(1.0,
            animations: {
              //  self.myView.alpha = 0
            },
            completion: { finished in
               // self.myView.removeFromSuperview()
            }
        )
    }
    
}