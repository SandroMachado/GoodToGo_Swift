//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func getSubViewWithTag(tag: Int) -> UIView?
    {
        return self.viewWithTag(tag);
    }
    
    func getSubViewsWithTag(tag: Int) -> [UIView]
    {
        return getSubViewsWithTag(tag, tagMax: tag);
    }
    
    func getSubViewsWithTag(tagMin: Int, tagMax: Int) -> [UIView]
    {
        var result = [UIView]()
        for subview in self.subviews
        {
            result += subview.getSubViewsWithTag(tagMin, tagMax: tagMax)
            if(subview.tag>=tagMin && subview.tag<=tagMax)
            {
                result.append(subview)
            }
        }
        return result;
    }
}