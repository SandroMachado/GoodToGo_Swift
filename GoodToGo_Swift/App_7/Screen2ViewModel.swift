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
    var commentsCount: String { get }
    var avatar: UIImage? { get }
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
    var avatar: UIImage?
    
    var viewNeedsReload: Dynamic<Bool>

    init(item:TableItem) {
        self.viewNeedsReload = Dynamic<Bool>(false)
        self.controllerTitle = "Post details"
        self.body            = item.description
        let post             = DBTablePosts.recordWithRowId(item.id)
      //  let user             = DBTableUsers.recordWithRowId(post.userId)
        let email            = ""//user.email
        let count            = DBTableComments.comentsCountFor(post.id)
        self.username        = ""//user.name
        self.articleTitle    = item.title
        self.commentsCount   = "\(count) comments"
      /*
        // Check for user Avatar image
        let imageName   = "avatar_\(email).png"
        let avatarImage = RJSFilesManager.getImage(imageName)
        
        if(HaveValue(avatarImage)) {
            // We find the avatar image on the file system!
            self.avatar = avatarImage
        }
        else {
            if(RJSUtils.existsInternetConnection())
            {
                // We didnt find the avatar image on the file system. Let fetch it....
                let imageURL = "https://api.adorable.io/avatars/105/\(email).png"
                RJSDownloadsManager.downloadImage(imageURL) { (result, error) -> Void in
                    if(HaveValue(error) && !HaveValue(result)) {
                        RJSErrorsManager.handleError(error)
                        // Error? Return a defautl image...
                        self.avatar = UIImage(named: App7Constants.Misc.DefaultAvatarImage)
                    }
                    else {
                        // Set the image
                        self.avatar = result
                        // Cache the image for future use
                        RJSFilesManager.saveImage(imageName, folder: RJSFilesManager.Folder.Documents, image: result)
                    }
                    self.viewNeedsReload.value = true
                }
            }
            else {
                // No internet connection to download image. Using default
                self.avatar = UIImage(named: App7Constants.Misc.DefaultAvatarImage)
            }
        }
*/
        self.viewNeedsReload.value = true
    }
    
    func makeSomeOperation() -> Void
    {
        self.viewNeedsReload.value = true;
    }
    

}
