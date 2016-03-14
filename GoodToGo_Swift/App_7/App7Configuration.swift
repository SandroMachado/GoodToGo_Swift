  //
  //  GoodToGo_Swift
  //
  //  Copyright © 2016 Ricardo Santos. All rights reserved.
  //
  
  import UIKit
  
  extension AppConfiguration {
    
    static func prepare() -> Int
    {
    
        // Prepare navigation bar layout
        RJSLayoutsManager.App7.LayoutNavigationBar()

        // If we have comics stored, I dont request for more in the aplication lauch
        let storedComicsCount = DBTableComic.recordsCount()
        if(storedComicsCount<App7Constants.MarvelApi.MaxNumberOfComicsInSingleRequest) {
            // Download first page of commics
            App7MarvelAPI.getComics(0, limit: App7Constants.MarvelApi.MaxNumberOfComicsInSingleRequest, cleanCachedImages: false, debug: false)
        }
        
        return 1
    }
    
    static func setUserDropBoxAcessToken(userAcessToken:String) -> Void {
        RJSStorages.saveToDefaults(userAcessToken, key: "dropbox_api_userAcessToken")
    }
    
    static func getUserDropBoxAcessToken() -> String {
        return ToString( RJSStorages.readFromDefaults("dropbox_api_userAcessToken"))
    }
    
  }
  
