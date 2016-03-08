//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

struct RJSDownloadsManager
{
    static private func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    static func downloadImage(imageURL: String, completion: (result: UIImage!, error: NSError!) -> Void) {
        
        RJSUtils.setActivityIndicatorToState(true, identifier:imageURL)

        let url = NSURL(string: imageURL)
        getDataFromUrl(url!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else {
                    completion(result: nil, error: error)
                    return
                }
                let image = UIImage(data: data)
                if(!HaveValue(image))
                {
                    DLogError("Error downloading image [\(imageURL)]")
                }
                completion(result: image, error: error)
                RJSUtils.setActivityIndicatorToState(false, identifier:imageURL)
            }
        }
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        let imageURL1 = "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png"
        RJSDownloadsManager.downloadImage(imageURL1) { (result, error) -> Void in
            assert(HaveValue(result))
            assert(!HaveValue(error))
            assert(NSThread.isMainThread())
        }
        
        let imageURL2 = "asdasdasdas"
        RJSDownloadsManager.downloadImage(imageURL2) { (result, error) -> Void in
            assert(!HaveValue(result))
            assert(HaveValue(error))
        }
        
    }
}
