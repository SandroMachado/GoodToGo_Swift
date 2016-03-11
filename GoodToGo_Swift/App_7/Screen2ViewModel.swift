//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

protocol Screen2ViewModelProtocol {
    var controllerTitle: String { get }
    var comicTitle: String { get }
    var comicDescription: String { get }
    var viewNeedsReload: Dynamic<Bool> { get }
}

/*
 * ViewModel
 */
final class Screen2ViewModel : Screen2ViewModelProtocol {
    
    var controllerTitle: String
    var comicTitle: String
    var comicDescription: String
    
    internal var viewNeedsReload: Dynamic<Bool>
    private  var currentItem : TableItem
    
    // MARK: Public
    
    init(item:TableItem) {
        currentItem = item
        self.viewNeedsReload  = Dynamic<Bool>(false)
        self.controllerTitle  = "Comic details"
        self.comicDescription = App7ViewModelUseCases.fixCommicDescription(item.description)
        self.comicTitle       = item.title

        self.viewNeedsReload.value = true
    }
    
    // Uploads the current image to the dropbox
    func uploadImageToDropbox () -> Void {
        // Get the name of the image (the folder in the dropbox, is the same that the folder of the cached image)
        let name = App7ViewModelUseCases.thumbnailURLToToFileSystemName(currentItem)
        getCoverImage({ (image) -> Void in
            App7ViewModelUseCases.uploadToDropBox(name, image: image)
            RJSMessagesManager.showSmallTopMessage("Cover image uploaded to dropbox...")
        })
    }
    
    func replaceCoverImageForCurrentCommic(newImage:UIImage) {
        
        // Salvar a imagem no sistema de ficheiros
        let name = App7ViewModelUseCases.thumbnailURLToToFileSystemName(currentItem)
        RJSFilesManager.saveImage(name, folder: RJSFilesManager.Folder.Documents, image: newImage)
        
        // Reload...
        setViewNeedsToReadInMainTread()
        
        // Upload da nova imagem para a dropbox
        uploadImageToDropbox()
    }
    
    func getCoverImage(completion:(newImage: UIImage) -> Void) {
        App7ViewModelUseCases.getCoverImage(currentItem) { (result) -> Void in
            // Make sure that UI updates are executed in the MainTread
            RJSBlocks.executeInMainTread({ () -> () in
                completion(newImage:result)
            })
        }
    }
    
    // MARK: Private

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
    
    // MARK : Public
    func makeSomeOperation() -> Void
    {
        self.viewNeedsReload.value = true;
    }
    
}
