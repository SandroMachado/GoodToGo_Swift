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
        let contentType              = "application/octet-stream;"
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
    private static var connected = false
    static func connect(appKey:String) -> Void {
        guard !appKey.isEmpty && !connected else {
            DLogWarning("Ignored")
            return
        }
        connected = true
        Dropbox.setupWithAppKey(appKey)
    }

    /**
     * Step 2 - Authorize controller
     * (This opens a dialog where the user can enter is password
     */
    static func authorizeFromController(controller:UIViewController) -> Void {
        
        // Connect to the DropBox
        RJSDropBoxManager.connect(AppGenericConstants.APIs.DropboxAppKey)
        
        if (Dropbox.authorizedClient == nil) {
            Dropbox.authorizeFromController(controller)
        }
        else {
            DLogWarning("Controller \(controller) is already authorized!")
            /*let userToken = ToString(RJSStorages.readFromKeychain(App7Constants.Keys.DropboxUserAcessToken))
            RJSDropBoxManager.getCurrentAcount(userToken) { (result, error) -> Void in
                DLog(result)
            }*/
        }
    }

    static func disconect() -> Void {
        if(Dropbox.authorizedClient==nil) {
            DLogWarning("Allready disconnected")
        } else {
            Dropbox.unlinkClient()
        }
    }
    
    static func getCurrentAcount(secretToken:String, completion: (result: AnyObject!, error: NSError!) -> Void) {
        
        // Connect to the DropBox
        RJSDropBoxManager.connect(AppGenericConstants.APIs.DropboxAppKey)
        
        guard !secretToken.isEmpty else {
            DLogWarning("Ignored")
            return
        }
        
        if(secretToken.countUTF8()<40) {
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
    
    // FIX: !! Images are not upload the right way!
    static func uploadImage(secretToken:String, image:UIImage, var imageName:String, completion: (result: AnyObject!, error: NSError!) -> Void) {
       
        // Connect to the DropBox
        RJSDropBoxManager.connect(AppGenericConstants.APIs.DropboxAppKey)
        
        guard !secretToken.isEmpty else {
            DLogWarning("Ignored..")
            return
        }
        
        if(secretToken.countUTF8()<40) {
            DLogWarning("Are you sure that you are using the rigth token? [\(secretToken)]")
        }
        
        // "comic_covers\\id_8461_f3056e228fe7282ae289a49b087d9bbe.png" -> "comic_covers/id_8461_f3056e228fe7282ae289a49b087d9bbe.png"
        imageName = imageName.replace("\\", newChar: "/")
        let apiArg = "{\"path\": \"/comic_covers/\(imageName)\", \"mode\": \"overwrite\"}"
        if(!RJSJSON.isJSON(apiArg)) {
            DLogError("Bad JSON : [\(apiArg)]")
        }
    
        // example image data
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        
        if(true) {
            
            let url = "https://content.dropboxapi.com/2-beta-2/files/upload"

            let headers = [
                "Authorization": "Bearer \(secretToken)",
                "Content-Type": "application/octet-stream",
                "Dropbox-API-Arg": apiArg,
                "data-binary": "\(imageData)"
            ]
            
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

        
      }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        //RJSDropBoxManager.getCurrentAcount(AppGenericConstants.APIs.DropboxAcessTokenSecret) { (result, error) -> Void in
        //    assert(HaveValue(result))
        //    assert(!HaveValue(error))
        //}
        
    }
    
}



