//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

struct RJSErrorsManager
{
    static func handleError(error: NSError?)  -> Bool
    {
        guard HaveValue(error) else {
            DLogWarning("Ignored")
            return false
        }
        RJSCrashlytics.logError("RJSErrorsManager", error: error!)
        DLogError(error)
        return true;
    }
    
    /// FIX: lower case this
    static func NSErrorWith(domain: String) -> NSError
    {
        return NSErrorWith(domain, code: 9999, dict: nil)
    }
    
    /// FIX: lower case this
    static func NSErrorWith(domain: String, code: Int, dict: [NSObject : AnyObject]?) -> NSError
    {
        return NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotOpenFile, userInfo: nil)
    }
    
}
