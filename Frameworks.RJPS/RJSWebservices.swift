//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

struct  RJSWebservices
{
    
    static func makeRestRequest(serverURL: String?, webServiceParans : AnyObject, completitionHandler: (result: String?, error: NSError?) -> Void)
    {

    }
    
    static func asynchonousRequest(url: String?, completion: (result: AnyObject?, error: NSError?) -> Void)
    {
        guard !String.isNullOrEmpty(url) else {
            completion(result: nil, error: nil)
            DLogWarning("Ignored...")
            return
        }
        RJSUtils.setActivityIndicatorToState(true, identifier:url!)
        let request: NSURLRequest  = NSURLRequest(URL: NSURL(string: url!)!)
        let queue:NSOperationQueue = NSOperationQueue()
          NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{
            (   response: NSURLResponse?,
                responseData: NSData?,
                error: NSError?
            ) -> Void in
            if((responseData) != nil)
            {
                let stringResult: String? = NSString(data: responseData!, encoding: NSUTF8StringEncoding) as? String
                if(RJSJSON.isJSON(stringResult))
                {
                    completion(result: RJSJSON.convertObjectToJSONToObject(stringResult), error: nil)
                }
                else
                {
                    completion(result: stringResult, error: nil)
                }
            }
            else
            {
                completion(result: nil, error: error)
            }
            RJSUtils.setActivityIndicatorToState(false, identifier:url!)
        })
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        let url1 = "http://private-anon-85ff4f27d-practical.apiary-mock.com/properties/17219"
        RJSWebservices.asynchonousRequest(url1) { (result, error) -> Void in
            assert(HaveValue(result))
            assert(!HaveValue(error))
        };
        
        let url2 = ""
        RJSWebservices.asynchonousRequest(url2) { (result, error) -> Void in
            assert(!HaveValue(result))
            assert(!HaveValue(error))
        };
        
    }
}

