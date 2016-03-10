//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

import SystemConfiguration

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress              = sockaddr_in()
        zeroAddress.sin_len          = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family       = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable     = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

struct  RJSUtils
{
    
    struct Platform {
        static let isSimulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }()
    }

    static func existsInternetConnection() -> Bool {
        return Reachability.isConnectedToNetwork();
    }
    
    static func isMainThread() -> Bool {
        return NSThread.isMainThread();
    }
    
    static func guid() -> String
    {
        return NSUUID().UUIDString;
    }
    
    // TODO: End implementation using identifier
    static var activityIndicatorToState : Bool = false
    static func setActivityIndicatorToState(state : Bool, identifier:String="") -> Void
    {
        if(activityIndicatorToState==state)
        {
            return;
        }
        activityIndicatorToState = state;
        UIApplication.sharedApplication().networkActivityIndicatorVisible = state
    }
    
    static func randomInt(min : Int, max: Int) -> Int
    {
        if(min>max)
        {
            return 0;
        }
        if(min==max)
        {
            return min;
        }
        return Int(arc4random_uniform(UInt32(max-min+1)))+min;
    }
    
    static func postNotificaitonWithName(name : String) -> Bool
    {
        if(HaveValue(name))
        {
            DLog("Posting notification [\(name)]")
            // Always do in MainThread
            if(NSThread.isMainThread()) {
                NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil)
            }
            else {
                RJSBlocks.executeInMainTread({ () -> () in
                    NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil)
                })
            }
            return true;
        }
        return false;
    }
    
    static func isSimulator() -> Bool
    {
        return Platform.isSimulator
    }

    static func isRealDevice() -> Bool
    {
        return !Platform.isSimulator
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        var min = -5
        var max = 5
        for _ in 0..<50 {
            let result = RJSUtils.randomInt(min, max: max)
            assert(result>=min)
            assert(result<=max)
        }
        
        min = 0
        max = 0
        for _ in 0..<50 {
            let result = RJSUtils.randomInt(min, max: max)
            assert(result>=min)
            assert(result<=max)
        }
        
        min = 0
        max = 5
        for _ in 0..<50 {
            let result = RJSUtils.randomInt(min, max: max)
            assert(result>=min)
            assert(result<=max)
        }
    }
    
}



