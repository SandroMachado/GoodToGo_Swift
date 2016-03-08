//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{    
    static func colorFromRGBString(rgb: String) -> UIColor
    {
        let splited = rgb.splitByChar(",")

        if(splited.count>=3)
        {
            let red   = RJSConvert.stringToCGFloat(splited[0])
            let green = RJSConvert.stringToCGFloat(splited[1])
            let blue  = RJSConvert.stringToCGFloat(splited[2])
            if(splited.count==4)
            {
                let alpha = RJSConvert.stringToCGFloat(splited[3]);
                return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
            }
            else
            {
                return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
            }
        }
        DLogWarning("Invalid color \(rgb)")
        return UIColor.blackColor();
    }
}


