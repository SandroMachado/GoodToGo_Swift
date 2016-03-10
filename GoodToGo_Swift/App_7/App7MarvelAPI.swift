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
    

    // Safe init for control vars
    private static func convenienceInit() -> Void {
        if(currentLimit == 0) {
            currentLimit = 20
        }
    }

    static func getNexComicsPage () -> Int {
        convenienceInit()
        currentOffset = currentOffset+1
        let limitOnAddMore = 20
        return getComics(currentOffset, limit:limitOnAddMore, cleanCachedImages: false, debug: false)
    }
 
    static func getPrevComicsPage () -> Int {
        convenienceInit()
        currentOffset = currentOffset-1
        let limitOnAddMore = 20
        return getComics(currentOffset, limit:limitOnAddMore, cleanCachedImages: false, debug: false)
    }
    
    static func getComics(var offset:Int=0, var limit:Int=100, cleanCachedImages:Bool=false, debug:Bool=false) -> Int
    {
        
       /*
        * Download data
        */
        
        guard RJSUtils.existsInternetConnection() else {
            RJSUtils.postNotificaitonWithName(App7Constants.Notifications.ShowNoInternetConnection)
            return 0
        }
        
        // Keep the user informed of whats going on
        RJSMessagesManager.showSmallTopMessage("Updating commics...")

        if(cleanCachedImages) {
            // Clean cached images
            RJSFilesManager.clearFolder(RJSFilesManager.Folder.Documents)
            
            // Clean chached records
            DBTableComic.deleteAllRecords()
        }

        if(offset<0) {
            offset = 0
        }
        
        App7MarvelAPI.currentOffset = offset
        App7MarvelAPI.currentLimit  = limit
        
        if(limit>100 || limit<1) {
            DLogWarning("Limit cant be greater than 100.") // https://developer.marvel.com/docs#!/public/getComicsCollection_get_6
            limit = 100
        }
        
        let timestamp = "\(NSDate().timeIntervalSince1970)"
        let hash      = "\(timestamp)\(App7Constants.MarvelApi.PrivateKey)\(App7Constants.MarvelApi.PublicKey)".md5()
        let headers = [
            "Accept-Encoding": "gzip", // Zip comunication to save data
        ]
        let params = ["apikey": App7Constants.MarvelApi.PublicKey, "ts":timestamp, "hash":hash, "limit":"\(limit)", "orderBy":"issueNumber", "offset":"\(offset)"]
        
        // Turn on the activity indicator
        RJSUtils.setActivityIndicatorToState(true, identifier: App7Constants.MarvelApi.CommicsEndPoint)
        
        // Get commics!
        Alamofire.request(.GET, App7Constants.MarvelApi.CommicsEndPoint, parameters: params, headers:headers)
            .responseJSON { response in
                
                if let JSON = response.2.value {
                    //let attributionHTML = ToString(JSON["attributionHTML"])
                    //let attributionText = ToString(JSON["attributionText"])
                    //let code            = ToString(JSON["code"])
                    //let copyright       = ToString(JSON["copyright"])
                    if let data = JSON["data"] {
                        let count   = RJSConvert.convertToInt(data!["count"])
                        let limit   = RJSConvert.convertToInt(data!["limit"])
                        let offset  = RJSConvert.convertToInt(data!["offset"])
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
                    
                    print("Stored records count : \(DBTableComic.recordsCount())" )

                    // Turn off the activity indicator
                    RJSUtils.setActivityIndicatorToState(false, identifier: App7Constants.MarvelApi.CommicsEndPoint)
                    
                    // Keep the user informed of whats going on
                    RJSMessagesManager.showSmallTopMessage("Comics updated...")
                    
                    // Warn the ViewModel that there is new data available
                    RJSUtils.postNotificaitonWithName(App7Constants.Notifications.TableComicUpdated)
                }
        }
        
    
        return 1
    }
  }
  
