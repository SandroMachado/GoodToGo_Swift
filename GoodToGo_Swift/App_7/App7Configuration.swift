  //
  //  GoodToGo_Swift
  //
  //  Copyright © 2016 Ricardo Santos. All rights reserved.
  //
  
  import UIKit
  import RealmSwift
  import Alamofire
  import CryptoSwift
  
  extension AppConfiguration {
    
    static func prepare() -> Int
    {
        
        // Prepare navigation bar layout
        RJSLayoutsManager.App7.LayoutNavigationBar()
        
       /*
        * Download data
        */
        
        guard RJSUtils.existsInternetConnection() else {
            return 0
        }
        
        // Clean cache
        RJSFilesManager.clearFolder(RJSFilesManager.Folder.Documents)
        
        let timestamp = "\(NSDate().timeIntervalSince1970)"
        let hash      = "\(timestamp)\(App7Constants.MarvelApi.PrivateKey)\(App7Constants.MarvelApi.PublicKey)".md5()
        
        /// TODO: Add Accept-Encoding:gzip to request header to save data (http://developer.marvel.com/documentation/generalinfo - http://stackoverflow.com/questions/26784601/setting-custom-http-headers-in-alamofire-in-ios-7-not-working
        let params = ["apikey": App7Constants.MarvelApi.PublicKey, "ts":timestamp, "hash":hash]
        RJSUtils.setActivityIndicatorToState(true, identifier: App7Constants.MarvelApi.CommicsEndPoint)
        Alamofire.request(.GET, App7Constants.MarvelApi.CommicsEndPoint, parameters: params)
            .responseJSON { response in
                
                /// TODO: colocar autorelease
                if let JSON = response.2.value {
                    //print("JSON: \(JSON)")
                    let attributionHTML = ToString(JSON["attributionHTML"])
                    let attributionText = ToString(JSON["attributionText"])
                    let code            = ToString(JSON["code"])
                    let copyright       = ToString(JSON["copyright"])
                    if let data = JSON["data"] {
                        let count   = RJSConvert.convertToInt(data!["count"])
                        let limit   = RJSConvert.convertToInt(data!["limit"])
                        let offset  = RJSConvert.convertToInt(data!["offset"])
                        let results = data!["results"]
                        DBTableComic.deleteAllRecords() // If we received values, lets delete the old ones...
                        for index in 0...count-1 {
                            let comic = results!![index]
                            let test = comic as! [String : AnyObject]
                            let keys = test.keys

                           // print("\(comic)")
                            autoreleasepool {
                                DBTableComic(dic:comic as! [String : AnyObject]).save()
                            }
                        }
                        
                        if(false) {
                            let records = DBTableComic.allRecords()
                            for index in 0...count-1 {
                                print(records[index].thumbnail)
                            }
                        }
                        print(DBTableComic.recordsCount())
                        RJSUtils.setActivityIndicatorToState(false, identifier: App7Constants.MarvelApi.CommicsEndPoint)
                        RJSMessagesManager.showSmallTopMessage("Comics updated...")
                        RJSUtils.postNotificaitonWithName(App7Constants.Notifications.TableComicUpdated)
                    }
                }
        }
        
        return 1;
        
        RJSMessagesManager.showSmallTopMessage("Updating records...")
        
        let download3Comments = {
            RJSUtils.setActivityIndicatorToState(true, identifier: App7Constants.MarvelApi.Commments)
            RJSWebservices.asynchonousRequest(App7Constants.MarvelApi.Commments) { (result, error) -> Void in
                if(HaveValue(result))
                {
                    DBTableComments.deleteAllRecords() // If we received values, lets delete the old ones...
                    for post in result as! NSArray
                    {
                        autoreleasepool {
                            DBTableComments(dic:post as! [String : AnyObject]).save()
                        }
                    }
                }
                else
                {
                    RJSErrorsManager.handleError(error)
                }
                RJSUtils.setActivityIndicatorToState(false, identifier: App7Constants.MarvelApi.Commments)
                RJSMessagesManager.showSmallTopMessage("Comments updated...")
                RJSUtils.postNotificaitonWithName(App7Constants.Notifications.TableCommentsUpdated)
            };
        }
        
        let download2Posts = {
            RJSUtils.setActivityIndicatorToState(true, identifier: App7Constants.MarvelApi.Posts)
            RJSWebservices.asynchonousRequest(App7Constants.MarvelApi.Posts) { (result, error) -> Void in
                if(HaveValue(result))
                {
                    DBTablePosts.deleteAllRecords() // If we received values, lets delete the old ones...
                    for post in result as! NSArray
                    {
                        autoreleasepool {
                            DBTablePosts(dic:post as! [String : AnyObject]).save()
                        }
                    }
                }
                else
                {
                    RJSErrorsManager.handleError(error)
                }
                RJSUtils.setActivityIndicatorToState(false, identifier: App7Constants.MarvelApi.Posts)
                RJSMessagesManager.showSmallTopMessage("Posts updated...")
                RJSUtils.postNotificaitonWithName(App7Constants.Notifications.TablePostsUpdated)
                download3Comments()
            };
            
        }
        
        
        return 1
    }
  }
  
