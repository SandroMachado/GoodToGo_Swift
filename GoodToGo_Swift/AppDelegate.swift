//
//  AppDelegate.swift
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if(RJSUtils.isRealDevice())
        {
            Fabric.with([Answers.self, Crashlytics.self])
        }

        RJSAppAndDeviceInfo.numberOfLoginsIncrement()

        AppConfiguration.prepare()
      
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        #if DROPBOX_ENABLED
            if let authResult = Dropbox.handleRedirectURL(url) {
                switch authResult {
                case .Success:
                    // TODO: improve RegExp
                    let matches        = RJSRegExp.matchesForRegexInText("access_token=[^&]+&token_type", text: ToString(url))
                    var userAcessToken = ToString(matches[0])
                    userAcessToken     = userAcessToken.replace("access_token=", with: "")
                    userAcessToken     = userAcessToken.replace("&token_type",   with: "")
                    RJSStorages.saveToKeychain(userAcessToken, key: AppConstants.DefaultsKey.DropboxUserAcessToken)
                case .Error( _, let description):
                    print("Error: \(description)")
                }
            }
        #endif
        return false
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

