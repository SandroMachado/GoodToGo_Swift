//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

struct RJSDropBoxManager
{
    /**
     * Step 1 - Connect to the DropBox
     * Call inside AppDelegate application:didFinishLaunchingWithOptions
     */
    static func connect(appKey:String) -> Void {
        guard !appKey.isEmpty else {
            DLogWarning("Ignored")
            return
        }
        Dropbox.setupWithAppKey(appKey)
    }

    /**
     * Step 2 - Authorize controller
     * Call inside AppDelegate application:didFinishLaunchingWithOptions
     */
    static func authorizeFromController(controller:UIViewController) -> Void {
        if (Dropbox.authorizedClient == nil) {
            Dropbox.authorizeFromController(controller)
        }
        else {
            DLogWarning("User is already authorized!")
            print("User is already authorized!")
        }
    }

    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {

        

        
    }
    
}
