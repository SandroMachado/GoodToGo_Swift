//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/*
 * What to put here?
 *  1 - Things (actions) that are shared beetween ViewModel's
 *  2 - Things that are complex busniss
 *  3 - Data acess
 *
 * !! ViewControlers DONT use this !!
 */

struct App7ViewModelUseCases {
    
    // Some of the comic descriptions have clearly invalid chars. 
    // This function trys to fix some of then
    static func fixCommicDescription(var textToEscape:String) -> String {
        textToEscape = textToEscape.replace("<null>", newChar: "")
        textToEscape = textToEscape.replace("<br>", newChar: "\n")
        if(textToEscape.trim().isEmpty) {
            textToEscape = "N/A"
        }
        return textToEscape
    }
    
    static func uploadToDropBox(imageName:String, image:UIImage)-> Void {
        RJSDropBoxManager.uploadImage(AppGenericConstants.APIs.DropboxAcessTokenSecret, image:image, imageName:imageName ) {
            (result, error) -> Void in
            print(result)
        }
    }
    
    // Given some Url, calculates the name of that image in the file system
    static func thumbnailURLToToFileSystemName(tableItem:TableItem)-> String {
        var imageNameInFileSystem = "id_\(tableItem.id)-\(tableItem.thumbnail.md5())"
        //imageNameInFileSystem     = "comic_covers\\" + imageNameInFileSystem + ".png"
        imageNameInFileSystem     = "" + imageNameInFileSystem + ".png"
        return imageNameInFileSystem
    }
    
    // Given some TableItem, returns the rigth image to bind
    static func getCoverImage(tableItem:TableItem, completion:(newImage: UIImage) -> Void) {
        
        // The name of the imagem in the file system is the MD5 value of the commic id and the comic cover url
        let imageNameInFileSystem = thumbnailURLToToFileSystemName(tableItem)
        let imageInFileSystem     = RJSFilesManager.getImage(imageNameInFileSystem)
        
        if(HaveValue(imageInFileSystem)) {
            // We find the avatar image on the file system!
            completion(newImage: imageInFileSystem!)
            return
        }

        if(RJSUtils.existsInternetConnection())
        {
            // While we download the imagem, let's set a temporary image...
            let downloadingImage = UIImage(named: AppGenericConstants.ImagesBlundle.Downloading1)
            completion(newImage: downloadingImage!)
            
            // We didnt find the cover image on the file system. Let fetch it....
            RJSDownloadsManager.downloadImage(tableItem.thumbnail) { (result, error) -> Void in
                if(HaveValue(error) && !HaveValue(result)) {
                    
                    // Error? Handle it
                    RJSErrorsManager.handleError(error)
                    
                    // Error? Return a default image...
                    let defaultImage = UIImage(named: App7Constants.Images.DefaultCoverImage)
                    completion(newImage: defaultImage!)
                }
                else {
                    // Set the image
                    completion(newImage: result!)
                    
                    // Cache the image for future use
                    RJSFilesManager.saveImage(imageNameInFileSystem, folder: RJSFilesManager.Folder.Documents, image: result)
                }
            }
        }
        else {
            // No internet connection to download image. Using default
            let defaultImage = UIImage(named: App7Constants.Images.DefaultCoverImage)
            completion(newImage: defaultImage!)
        }
     
    }
}

