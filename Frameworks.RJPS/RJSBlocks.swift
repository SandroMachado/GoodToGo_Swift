//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
//import UIKit

enum Tread
{
    case MainTread, BackgroundTread
}

struct  RJSBlocks
{
   /*
    * RJSBlocks.executeWithDelay(Tread.MainTread, delay: 1, block: {
    *     self.imgView1!.bump(size:5)
    * })
    */
    static func executeWithDelay(tread:Tread=Tread.MainTread, delay:Double=0, block:()->()) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        if(tread==Tread.MainTread)
        {
            dispatch_after(delayTime, dispatch_get_main_queue()) { block() }
        }
        else
        {
            dispatch_after(delayTime, dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) { block() }
        }
    }
    
    static func executeInTread(tread:Tread, block:()->()) {
        if(tread==Tread.MainTread)
        {
            executeInMainTread(block);
        }
        else
        {
            executeInBackgroundTread(block);
        }
    }
    
    static func executeInMainTread(block:()->()) {
        dispatch_async(dispatch_get_main_queue(),{block()})
    }
    
    static func executeInBackgroundTread(block:()->()) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { block(); })
    }
    
    /*
    * executeInBackgroundTreadWhitCompletionOnMainTread({print("ola")}, blockMain:{print("adeus")});
    */
    static func executeInBackgroundTreadWithCompletionOnMainTread(blockBack:()->(),
        blockMain:()->()) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            blockBack();
            dispatch_async(dispatch_get_main_queue(),{ blockMain()})
        })
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        executeInMainTread({assert(NSThread.isMainThread())})
        executeInBackgroundTread({assert(!NSThread.isMainThread())})
        executeInTread(Tread.MainTread, block: {assert(NSThread.isMainThread())});
        executeInTread(Tread.BackgroundTread, block: {assert(!NSThread.isMainThread())});
        executeInBackgroundTreadWithCompletionOnMainTread({assert(!NSThread.isMainThread())},
            blockMain: {assert(NSThread.isMainThread())});
    }
}

