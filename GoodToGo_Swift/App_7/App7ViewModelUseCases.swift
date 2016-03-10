//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/*
 * What to put here?
 *  1 - Things (actions) that are shared beetween ViewModel
 *
 * !! ViewControlers DONT use this !!
 */

struct App7ViewModelUseCases {
    
    static func getCoverImage(tableItem:TableItem, completion:(result: UIImage) -> Void) {
        
        // The name of the imagem in the file system is the MD5 value of the commic id and the comic cover url
        var imageNameInFileSystem = "\(tableItem.id)_\(tableItem.thumbnail)".md5()
        imageNameInFileSystem     = "comic_covers\\" + imageNameInFileSystem + ".png"
        
        let imageInFileSystem = RJSFilesManager.getImage(imageNameInFileSystem)
        
        if(HaveValue(imageInFileSystem)) {
            // We find the avatar image on the file system!
            completion(result: imageInFileSystem!)
            return
        }
        else {
            if(RJSUtils.existsInternetConnection())
            {
                
                // While we download the imagem, let's set a temporary image...
                let downloadingImage = UIImage(named: AppGenericConstants.ImagesBlundle.Downloading1)
                completion(result: downloadingImage!)
                
                // We didnt find the avatar image on the file system. Let fetch it....
                RJSDownloadsManager.downloadImage(tableItem.thumbnail) { (result, error) -> Void in
                    if(HaveValue(error) && !HaveValue(result)) {
                        
                        // Error? Handle it
                        RJSErrorsManager.handleError(error)
                        
                        // Error? Return a default image...
                        let defaultImage = UIImage(named: App7Constants.Images.DefaultCoverImage)
                        completion(result: defaultImage!)
                    }
                    else {
                        // Set the image
                        completion(result: result!)
                        
                        // Cache the image for future use
                        RJSFilesManager.saveImage(imageNameInFileSystem, folder: RJSFilesManager.Folder.Documents, image: result)
                    }
                }
            }
            else {
                // No internet connection to download image. Using default
                let defaultImage = UIImage(named: App7Constants.Images.DefaultCoverImage)
                completion(result: defaultImage!)
            }
        }
    }
}

