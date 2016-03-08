//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

protocol Getter {
    typealias NetworkStatus
    typealias Element
    func getUrl() -> String
    func getDataFrom(dictionary: NSDictionary) -> Element
    func get(success success: Element -> (), failure: NetworkStatus -> ())
}

extension Getter {
    func get(success success: Element -> (), failure: NetworkStatus -> ()) {
     /*   let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
        dispatch_async(dispatch_get_global_queue(qos, 0)) {
            
            let responseHandler = ResponseHandler()
            responseHandler.failureCallback = { status in
                dispatch_async(dispatch_get_main_queue()) {
                    failure(status)
                }
            }
            responseHandler.successCallback = { dictionary in
                let data = self.getDataFrom(dictionary)
                dispatch_async(dispatch_get_main_queue()) {
                    success(data)
                }
            }
            Network.Requester(networkResponseHandler: responseHandler).makeGet(self.getUrl())

        }*/
    }
}

struct LProtocolExtensions
{
    static func start () -> Void
    {
        
    }
}




