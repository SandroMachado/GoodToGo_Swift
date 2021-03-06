  //
  //  GoodToGo_Swift
  //
  //  Copyright © 2016 Ricardo Santos. All rights reserved.
  //
  
  import UIKit
  import RealmSwift
  import Alamofire
  import CryptoSwift
  
  class App7MarvelAPI {
    
    // Control var's
    private static var currentOffset = 0
    private static var currentLimit  = 0
    private static var lock = false // Used to lock the requests and dont let do more than one at the same time

    // Safe init for control vars
    private static func convenienceInit() -> Void {
        if(currentLimit == 0) {
            currentLimit = 20
        }
    }

    static func getNexComicsPage () -> Int {
        convenienceInit()
        currentOffset = currentOffset+1
        let limitOnAddMore = 50
        return getComics(currentOffset, limit:limitOnAddMore, cleanCachedImages: false, debug: false)
    }
 
    static func getPrevComicsPage () -> Int {
        convenienceInit()
        currentOffset = currentOffset-1
        let limitOnAddMore = 50
        return getComics(currentOffset, limit:limitOnAddMore, cleanCachedImages: false, debug: false)
    }
    
    static func getComics(var offset:Int=0, var limit:Int=30, cleanCachedImages:Bool=false, debug:Bool=false) -> Int
    {
        
       /*
        * Download data
        */
        
        guard RJSUtils.existsInternetConnection() else {
            RJSUtils.postNotificaitonWithName(App7Constants.Notifications.ShowNoInternetConnection)
            return 0
        }
        
        guard !lock else {
            DLogWarning("Request ignored. Still waiting for the last one")
            return 0
        }
        
        // Lock the API to new requests
        lock = true 
        
        // Keep the user informed of whats going on
        RJSMessagesManager.showSmallTopMessage("Fetching comics...")

        if(cleanCachedImages) {
            // Clean cached images
            RJSFilesManager.clearFolder(RJSFilesManager.Folder.Documents)
        }

        if(offset<0) {
            offset = 0
        }
        
        if(limit>App7Constants.MarvelApi.MaxNumberOfComicsInSingleRequest || limit<1) {
            // https://developer.marvel.com/docs#!/public/getComicsCollection_get_6
            DLogWarning("Limit cant be greater than \(App7Constants.MarvelApi.MaxNumberOfComicsInSingleRequest).")
            limit = App7Constants.MarvelApi.MaxNumberOfComicsInSingleRequest
        }
        
        App7MarvelAPI.currentOffset = offset
        App7MarvelAPI.currentLimit  = limit
        
        let timestamp = "\(NSDate().timeIntervalSince1970)"
        
        let hash      = "\(timestamp)\(App7Constants.MarvelApi.PrivateKey)\(App7Constants.MarvelApi.PublicKey)".md5()
        
        let headers   = ["Accept-Encoding": "gzip"] // Zip comunication to save data
        
        let params    = ["apikey": App7Constants.MarvelApi.PublicKey, "ts":timestamp, "hash":hash, "limit":"\(limit)", "orderBy":"issueNumber", "offset":"\(offset)"]
        
        // Turn on the activity indicator
        RJSUtils.setActivityIndicatorToState(true, identifier: App7Constants.MarvelApi.ComicsEndPoint)
        
        // Make request in background
        RJSBlocks.executeInBackgroundTread { () -> () in
            
            Alamofire.request(.GET, App7Constants.MarvelApi.ComicsEndPoint, parameters: params, headers:headers)
                .responseJSON { response in
                    
                    // Save/handles result in background
                    RJSBlocks.executeInBackgroundTread { () -> () in
                        if let JSON = response.2.value {
                            if let data = JSON["data"] {
                                let count   = RJSConvert.convertToInt(data!["count"])
                                let results = data!["results"]
                                for index in 0...count-1 {
                                    let comic = results!![index]
                                    autoreleasepool {
                                        DBTableComic(dic:comic as! [String : AnyObject]).save()
                                    }
                                }
                                
                                if(debug) {
                                    print("Stored records count : \(DBTableComic.recordsCount())" )
                                }
                            }
                            
                            // Turn off the activity indicator
                            RJSUtils.setActivityIndicatorToState(false, identifier: App7Constants.MarvelApi.ComicsEndPoint)
                            
                            // Keep the user informed of whats going on
                            RJSMessagesManager.showSmallTopMessage("Comics updated/added...")
                            
                            // Warn the ViewModel that there is new data available
                            RJSUtils.postNotificaitonWithName(App7Constants.Notifications.TableComicUpdated)
                            
                            // Unlock the API to new requests
                            lock = false
                        }
                        
                    }
            }
        }
        
        return 1
    }
  }
  
