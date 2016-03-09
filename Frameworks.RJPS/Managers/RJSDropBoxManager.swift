//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import Alamofire

/*
 * https://blogs.dropbox.com/developers/2015/04/a-preview-of-the-new-dropbox-api-v2/
 */

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
            DLogWarning("Controller \(controller) is already authorized!")
        }
    }

    static func getCurrentAcount(secretToken:String, completion: (result: AnyObject!, error: NSError!) -> Void) {
        guard !secretToken.isEmpty else {
            DLogWarning("Ignored")
            return
        }
        
        if(secretToken.countUTF8()<40 || !secretToken.containsString("-")) {
            DLogWarning("Are you sure that you are using the rigth token? [\(secretToken)]")
        }
        
        let headers = [
            "Authorization": "Bearer \(secretToken)",
            "data": "null"
        ]
        
        let url = "https://api.dropboxapi.com/2-beta-2/users/get_current_account"
        RJSUtils.setActivityIndicatorToState(true, identifier: url) // Turn activity indicator ON
        Alamofire.request(.POST, url, headers: headers)
            .responseData { (nsurlrequest, nshttpresponse, result) -> Void in
                // Prepare Result<NSData>
                let resultData = result as Result<NSData>
                let datastring = ToString(NSString(data: resultData.value!, encoding: NSUTF8StringEncoding))
                if(RJSJSON.isJSON(datastring)) {
                    let json = RJSJSON.convertObjectToJSONToObject(datastring)
                    completion(result: json, error: nil)
                }
                else {
                    // The result should be JSON! If we are here, something bad happned
                    let error = RJSErrorsManager.NSErrorWith(datastring)
                    RJSErrorsManager.handleError(error)
                    completion(result: nil, error: error)
                }
                RJSUtils.setActivityIndicatorToState(false, identifier: url) // Turn activity indicator OFF
        }
    }
    
    static func uploadImage(secretToken:String, image:UIImage, completion: (result: AnyObject!, error: NSError!) -> Void) {
        guard !secretToken.isEmpty else {
            DLogWarning("Ignored")
            return
        }
        
        if(secretToken.countUTF8()<40 || !secretToken.containsString("-")) {
            DLogWarning("Are you sure that you are using the rigth token? [\(secretToken)]")
        }
        
        /*
        curl -X POST https://api.dropboxapi.com/2-beta-2/files/upload \
        --header "Authorization: Bearer <access-token>" \
        --header "Content-Type: application/octet-stream" \
        --header "Dropbox-API-Arg: {\"path\": \"/cupcake.png\", \"mode\": \"overwrite\"}" \
        --data-binary @local-file.png
        */
        
        var apiArg = "{\"path\": \"/cupcake.png\", \"mode\": \"overwrite\"}"
       // apiArg = "{\"mode\": \"overwrite\"}"
        if(!RJSJSON.isJSON(apiArg)) {
            DLogError("Bad JSON : [\(apiArg)]")
        }
        
        let headers = [
            "Authorization": "Bearer \(secretToken)",
            "Content-Type": "application/octet-stream",
            "Dropbox-API-Arg": apiArg,
            "data-binary": "null"
        ]
        
       // let url = "https://api.dropboxapi.com/2-beta-2/files/upload"
        let url = "https://content.dropboxapi.com/2-beta-2/files/upload"

        RJSUtils.setActivityIndicatorToState(true, identifier: url) // Turn activity indicator ON
        Alamofire.request(.POST, url, headers: headers)
            .responseData { (nsurlrequest, nshttpresponse, result) -> Void in
                // Prepare Result<NSData>
                let resultData = result as Result<NSData>
                let datastring = ToString(NSString(data: resultData.value!, encoding: NSUTF8StringEncoding))
                if(RJSJSON.isJSON(datastring)) {
                    let json = RJSJSON.convertObjectToJSONToObject(datastring)
                    completion(result: json, error: nil)
                }
                else {
                    
                    debugPrint(datastring)
                    debugPrint(result)
                    
                    // The result should be JSON! If we are here, something bad happned
                    let error = RJSErrorsManager.NSErrorWith(datastring)
                    RJSErrorsManager.handleError(error)
                    completion(result: nil, error: error)
                }
                RJSUtils.setActivityIndicatorToState(false, identifier: url) // Turn activity indicator OFF
        }
        
        Alamofire.request(.POST, url, headers: headers)
        .responseJSON { (a, b, c) -> Void in
            debugPrint(c)
        }
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        RJSDropBoxManager.getCurrentAcount(AppGenericConstants.APIs.DropboxAcessTokenSecret) { (result, error) -> Void in
            assert(HaveValue(result))
            assert(!HaveValue(error))
        }
        
    }
    
}
