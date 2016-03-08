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
        
        let timestamp = "\(NSDate().timeIntervalSince1970)"
        let hash      = "\(timestamp)\(App7Constants.MarvelApi.PrivateKey)\(App7Constants.MarvelApi.PublicKey)".md5()
        
        let params = ["apikey": App7Constants.MarvelApi.PublicKey, "ts":timestamp, "hash":hash]
        Alamofire.request(.GET, "http://gateway.marvel.com/v1/public/comics", parameters: params)
            .responseJSON { response in
                if let JSON = response.2.value {
                    //print("JSON: \(JSON)")
                    let attributionHTML = ToString(JSON["attributionHTML"])
                    let attributionText = ToString(JSON["attributionText"])
                    let code            = ToString(JSON["code"])
                    let copyright       = ToString(JSON["copyright"])
                    if let data = JSON["data"] {
                        let count   = ToString(data!["count"])
                        let limit   = ToString(data!["limit"])
                        let offset  = ToString(data!["offset"])
                        let results = data!["results"]
                        print(results)
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
        
        let download1Users = {
            RJSUtils.setActivityIndicatorToState(true, identifier: App7Constants.MarvelApi.Users)
            RJSWebservices.asynchonousRequest(App7Constants.MarvelApi.Users) { (result, error) -> Void in
                if(HaveValue(result))
                {
                    DBTableUsers.deleteAllRecords() // If we received values, lets delete the old ones...
                    for post in result as! NSArray
                    {
                        autoreleasepool {
                            DBTableUsers(dic:post as! [String : AnyObject]).save()
                        }
                    }
                }
                else
                {
                    RJSErrorsManager.handleError(error)
                }
                RJSUtils.setActivityIndicatorToState(false, identifier: App7Constants.MarvelApi.Users)
                RJSMessagesManager.showSmallTopMessage("Users updated...")
                RJSUtils.postNotificaitonWithName(App7Constants.Notifications.TableUsersUpdated)
                download2Posts()
            };
        }
        
        download1Users()
 
        return 1
    }
  }
  
