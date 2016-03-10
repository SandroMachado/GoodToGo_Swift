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
        self.coverImage      = UIImage(named: App7Constants.Images.DefaultCoverImage)

        self.viewNeedsReload.value = true
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
