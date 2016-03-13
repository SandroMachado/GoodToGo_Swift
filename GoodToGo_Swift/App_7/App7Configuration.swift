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
  }
  
