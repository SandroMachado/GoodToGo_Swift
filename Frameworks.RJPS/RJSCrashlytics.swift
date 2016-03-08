//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import Crashlytics

struct RJSCrashlytics
{
    static func logError(eventName : String, error:NSError) -> Void
    {
        var attributes      = [String:String]()
        attributes["error"] = "\(error)"
        logCustomEventWithName("Error", attributes:attributes)
    }
    
    static func logCustomEventWithName(eventName : String, attributes:[String:String]?) -> Void
    {
        let deviceInfo                 = "\(RJSAppAndDeviceInfo.deviceInfo())"
        var customAttributes           = [String:String]()
        customAttributes["deviceInfo"] = deviceInfo
        if(HaveValue(attributes))
        {
            customAttributes["attributes"] = ToString(attributes)
        }
        Answers.logCustomEventWithName(eventName, customAttributes:customAttributes)
    }
    
    static func setUserInfo(userID userID : String, userName : String, userMail : String) -> Void
    {
        Crashlytics.sharedInstance().setUserIdentifier(userID)
        Crashlytics.sharedInstance().setUserEmail(userMail)
        Crashlytics.sharedInstance().setUserName(userName)
    }
    
    static func forceCrash() -> Void
    {
        Crashlytics.sharedInstance().crash()
    }
  }



