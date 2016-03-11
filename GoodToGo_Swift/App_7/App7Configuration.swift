  //
  //  GoodToGo_Swift
  //
  //  Copyright © 2016 Ricardo Santos. All rights reserved.
  //
  
  import UIKit
  //import RealmSwift
  //import Alamofire
  //import CryptoSwift
  
  extension AppConfiguration {
    
    static func prepare() -> Int
    {
        // Connect to the DropBox
        RJSDropBoxManager.connect(AppGenericConstants.APIs.DropboxAppKey)
        
        // Prepare navigation bar layout
        RJSLayoutsManager.App7.LayoutNavigationBar()
        
        // Download first page of commics
        App7MarvelAPI.getComics(0, limit: 100, cleanCachedImages: true, debug: false)
    
        return 1
    }
  }
  
