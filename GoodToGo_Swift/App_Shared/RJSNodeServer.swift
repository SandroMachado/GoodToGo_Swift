//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

struct RJSNodeServer {

    // TODO: Finish implementation
    static func sendMessageToServer(message : String, var messageType : String, methodName : String) -> Void
    {
        guard !String.isNullOrEmpty(message) else {
            return
        }
        
        if(String.isNullOrEmpty(messageType))
        {
            messageType = "Info";
        }
        
        let blundleIdentifier = NSBundle.mainBundle().bundleIdentifier;
        
        let appVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
        
        let message : String = "[\(blundleIdentifier) \(appVersion)] [\(message)] [\(methodName)]";
        
        print("\(message)")
        
    
    }
    
    // TODO: Finish implementation
    static func getValueFromServer(serverKey: String, completion: (result: String!, error: NSError!) -> Void)
    {
        completion(result: nil, error: nil)
    }
}

