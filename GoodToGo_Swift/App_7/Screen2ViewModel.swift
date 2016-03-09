//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

protocol Screen2ViewModelProtocol {
    var controllerTitle: String { get }
    var articleTitle: String { get }
    var body: String { get }
    var username: String { get }
    var coverImage: UIImage? { get }
    var viewNeedsReload: Dynamic<Bool> { get }
}

/*
 * ViewModel
 */
final class Screen2ViewModel : Screen2ViewModelProtocol {
    
    var controllerTitle: String
    var articleTitle: String
    var body: String
    var username: String
    var commentsCount: String
    var coverImage: UIImage?
    
    var viewNeedsReload: Dynamic<Bool>

    init(item:TableItem) {
        self.viewNeedsReload = Dynamic<Bool>(false)
        self.controllerTitle = "Comic details"
        self.body            = item.description
        self.username        = ""//user.name
        self.articleTitle    = item.title
        self.commentsCount   = "commentsCount"//"\(count) comments"
 
        // Check for user Avatar image
        // Check for user Avatar image
        var imageName = item.thumbnail.replace(":", newChar: "").replace("\\", newChar: "").replace("/", newChar: "")
        imageName = "comic_cover\\" + imageName
        let avatarImage = RJSFilesManager.getImage(imageName)
        
        if(HaveValue(avatarImage)) {
            // We find the avatar image on the file system!
            coverImage = avatarImage
        }
        else {
            if(RJSUtils.existsInternetConnection())
            {
                // We didnt find the avatar image on the file system. Let fetch it....
                RJSDownloadsManager.downloadImage(item.thumbnail) { (result, error) -> Void in
                    if(HaveValue(error) && !HaveValue(result)) {
                        
                        RJSErrorsManager.handleError(error)
                        
                        // Error? Return a defautl image...
                        self.coverImage = UIImage(named: App7Constants.Misc.DefaultAvatarImage)
                    }
                    else {
                        // Set the image
                        self.coverImage = result
                        // Cache the image for future use
                        RJSFilesManager.saveImage(imageName, folder: RJSFilesManager.Folder.Documents, image: result)
                    }
                    self.setViewNeedsToReadInMainTread()
                }
            }
            else {
                // No internet connection to download image. Using default
                self.coverImage = UIImage(named: App7Constants.Misc.DefaultAvatarImage)
            }
        }
        
        self.viewNeedsReload.value = true
    }
    
    func makeSomeOperation() -> Void
    {
        self.viewNeedsReload.value = true;
    }
    
    /*
    * This is needed cauze if we do self.viewNeedsReload.value=true, and we came from a notification (func handleNotification(sender:NSNotification)),
    * we will trigger the update in the ViewCrontroller from a background tread! Here we can ensure that the update is trigged in
    * the main tread
    */
    private func setViewNeedsToReadInMainTread() -> Void {
        if(NSThread.isMainThread()) {
            self.viewNeedsReload.value = true;
        }
        else {
            RJSBlocks.executeInMainTread { () -> () in
                self.viewNeedsReload.value = true;
            }
        }
    }
    

}
