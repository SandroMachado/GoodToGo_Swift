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
    
    private // this function creates the required URLRequestConvertible and NSData we need to use Alamofire.upload
    static func urlRequestWithComponents(urlString:String, parameters:Dictionary<String, String>, imageData:NSData) -> (URLRequestConvertible, NSData) {
        
        // create url request to send
        let mutableURLRequest        = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
        let boundaryConstant         = "myRandomBoundary12345";
        let contentType              = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add parameters
        for (key, value) in parameters {
            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        
        // add image
        uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"file.png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData(imageData)
        

        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        // return URLRequestConvertible and NSData
        return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
    }
    
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
        
        let apiArg = "{\"path\": \"/marvel/cupcake.png\", \"mode\": \"overwrite\"}"
        if(!RJSJSON.isJSON(apiArg)) {
            DLogError("Bad JSON : [\(apiArg)]")
        }
        
        var headers = [
            "Authorization": "Bearer \(secretToken)",
            "Content-Type": "application/octet-stream",
            "Dropbox-API-Arg": apiArg,
            "data-binary": String.randomStringWithLength(5000)
        ]
        
        // let url = "https://api.dropboxapi.com/2-beta-2/files/upload"
        var url = "https://content.dropboxapi.com/2-beta-2/files/upload"
        var url2 = "?authorization=Bearer \(secretToken)?arg=\(apiArg)".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
       // url = url + url2

        // example image data
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        
        if(false) {
            
            let urlRequest = urlRequestWithComponents(url, parameters: headers, imageData: imageData!)
            
            RJSUtils.setActivityIndicatorToState(true, identifier: url) // Turn activity indicator OFF
            Alamofire.upload(urlRequest.0, data: urlRequest.1)
                .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                    print("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
                }
                .responseData { (nsurlrequest, nshttpresponse, result) -> Void in
                    if(result.isFailure) {
                        // Fail
                        debugPrint(result)
                    }
                    else {
                        // Prepare Result<NSData>
                        let resultData = result as Result<NSData>
                        let datastring = ToString(NSString(data: resultData.value!, encoding: NSUTF8StringEncoding))
                        if(RJSJSON.isJSON(datastring)) {
                            let json = RJSJSON.convertObjectToJSONToObject(datastring)
                            completion(result: json, error: nil)
                        }
                        else {
                            
                            debugPrint(datastring)
                        }
                    }
                    RJSUtils.setActivityIndicatorToState(false, identifier: url) // Turn activity indicator OFF
            }
        }

        if(true) {
            //headers["data-binary"] = String.randomStringWithLength(256)
            
            RJSUtils.setActivityIndicatorToState(true, identifier: url) // Turn activity indicator ON
            Alamofire.request(.POST, url, headers: headers)
                .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                    print("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
                }
                .responseData { (nsurlrequest, nshttpresponse, result) -> Void in
                    if(result.isFailure) {
                        // Fail
                        debugPrint(result)
                    }
                    else {
                        let resultData = result as Result<NSData>
                        let datastring = ToString(NSString(data: resultData.value!, encoding: NSUTF8StringEncoding))
                        if(RJSJSON.isJSON(datastring)) {
                            let json = RJSJSON.convertObjectToJSONToObject(datastring)
                            completion(result: json, error: nil)
                        }
                        else {
                            // Fail
                            debugPrint(datastring)
                            debugPrint(resultData)
                        }
                    }
                    
                    RJSUtils.setActivityIndicatorToState(false, identifier: url) // Turn activity indicator OFF
            }
        }

        
    
        
        /*
        curl -X POST https://api.dropboxapi.com/2-beta-2/files/upload \
        --header "Authorization: Bearer <access-token>" \
        --header "Content-Type: application/octet-stream" \
        --header "Dropbox-API-Arg: {\"path\": \"/cupcake.png\", \"mode\": \"overwrite\"}" \
        --data-binary @local-file.png
        */
        
        /*
        let apiArg = "{\"path\": \"/marvel/cupcake.png\", \"mode\": \"overwrite\"}"
        if(!RJSJSON.isJSON(apiArg)) {
            DLogError("Bad JSON : [\(apiArg)]")
        }
        
        var imageData: NSData = UIImagePNGRepresentation(image)!
        var imageString = NSString(data:imageData, encoding:NSUTF8StringEncoding)
        //imageString = NSString(data:imageData, encoding:NSUnicodeStringEncoding)

        
        var parameters :Dictionary<String, String> = [
            "task": "task",
            "variable1": "var"
        ]
        
        let headers = [
            "Authorization": "Bearer \(secretToken)",
            "Content-Type": "application/octet-stream",
            "Dropbox-API-Arg": apiArg//,
          //  "data-binary": ToString(imageString)
        ]
        
       // let url = "https://api.dropboxapi.com/2-beta-2/files/upload"
        let url = "https://content.dropboxapi.com/2-beta-2/files/upload"

        // example image data
        let image_ = image;//UIImage(named: "177143.jpg")
        let imageData2 = UIImagePNGRepresentation(image_)
        
  
        
        let fileURL = NSBundle.mainBundle().URLForResource("Default", withExtension: "png")
        Alamofire.upload(.POST, url, headers: headers, file: fileURL!)
            .responseJSON { (a, b, c) -> Void in
                debugPrint(c)
        }
        
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
*/
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



