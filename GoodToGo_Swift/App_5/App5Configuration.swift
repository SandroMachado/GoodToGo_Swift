  //
  //  GoodToGo_Swift
  //
  //  Copyright © 2016 Ricardo Santos. All rights reserved.
  //
  
  import UIKit
  import RealmSwift
  
  extension AppConfiguration {
    
    static func prepare() -> Int
    {
        
        // Prepare navigation bar layout
        RJSLayoutsManager.App5.LayoutNavigationBar()
        
       /*
        * Download data
        */
        
        guard RJSUtils.existsInternetConnection() else {
            return 0
        }
        
        RJSMessagesManager.showSmallTopMessage("Updating records...")
        
        let download3Comments = {
            RJSUtils.setActivityIndicatorToState(true, identifier: App5Constants.URL.Commments)
            RJSWebservices.asynchonousRequest(App5Constants.URL.Commments) { (result, error) -> Void in
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
                RJSUtils.setActivityIndicatorToState(false, identifier: App5Constants.URL.Commments)
                RJSMessagesManager.showSmallTopMessage("Comments updated...")
                RJSUtils.postNotificaitonWithName(App5Constants.Notifications.TableCommentsUpdated)
            };
        }
        
        let download2Posts = {
            RJSUtils.setActivityIndicatorToState(true, identifier: App5Constants.URL.Posts)
            RJSWebservices.asynchonousRequest(App5Constants.URL.Posts) { (result, error) -> Void in
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
                RJSUtils.setActivityIndicatorToState(false, identifier: App5Constants.URL.Posts)
                RJSMessagesManager.showSmallTopMessage("Posts updated...")
                RJSUtils.postNotificaitonWithName(App5Constants.Notifications.TablePostsUpdated)
                download3Comments()
            };
            
        }
        
        let download1Users = {
            RJSUtils.setActivityIndicatorToState(true, identifier: App5Constants.URL.Users)
            RJSWebservices.asynchonousRequest(App5Constants.URL.Users) { (result, error) -> Void in
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
                RJSUtils.setActivityIndicatorToState(false, identifier: App5Constants.URL.Users)
                RJSMessagesManager.showSmallTopMessage("Users updated...")
                RJSUtils.postNotificaitonWithName(App5Constants.Notifications.TableUsersUpdated)
                download2Posts()
            };
        }
        
        download1Users()
 
        return 1
    }
  }
  
