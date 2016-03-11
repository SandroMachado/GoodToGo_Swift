//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

protocol Screen1ViewModelProtocol {
    var title: String { get }
    var tableViewSectionsTitle: [String] { get }
    var tableViewDataSource: [[TableItem]] { get }
    var viewNeedsReload: Dynamic<Bool> { get }
}

/*
 * ViewModel
 */
final class Screen1ViewModel : Screen1ViewModelProtocol {
    var title: String
    var tableViewSectionsTitle:[String] = []
    var tableViewDataSource:[[TableItem]] = []
    var viewNeedsReload: Dynamic<Bool>

    // MARK: Private
    @objc private func handleNotification(sender:NSNotification) {
        if(sender.name==App7Constants.Notifications.TableComicUpdated) {
            updateCommentsData()
        }
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
    
    // MARK: Public

    init() {
        
        self.title           = "Commics"
        self.viewNeedsReload = Dynamic<Bool>(false)
        
        updateCommentsData()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "handleNotification:",
            name: App7Constants.Notifications.TableComicUpdated,
            object: nil)
        
        // Warn the view controller that there is no internet connection
        if(!RJSUtils.existsInternetConnection()) {
            RJSUtils.postNotificaitonWithName(App7Constants.Notifications.ShowNoInternetConnection)
        }
    }
    
    func getCoverImage(tableItem:TableItem, completion:(result: UIImage) -> Void) {
        App7ViewModelUseCases.getCoverImage(tableItem) { (result) -> Void in
            RJSBlocks.executeInMainTread({ () -> () in
                completion(result:result)
            })
        }
    }
    
    func refreshAllData () -> Void {
        if (RJSUtils.existsInternetConnection()) {
            DBTableComic.deleteAllRecords()
            App7MarvelAPI.getComics(0, limit: 0, cleanCachedImages: false, debug: false)
        }
        else {
            RJSUtils.postNotificaitonWithName(App7Constants.Notifications.ShowNoInternetConnection)
            setViewNeedsToReadInMainTread()
        }
    }
    
    // Fetch more records from the Marvel API
    func loadMoreData () -> Void {
         App7MarvelAPI.getNexComicsPage()
    }
    
    // Get all the records currently stored in database and add then to (the var) sectionItems
    func updateCommentsData() -> Void {

        self.tableViewSectionsTitle.removeAll()
        self.tableViewDataSource.removeAll()
        
        var sectionItems = [TableItem]()
        let commics      = DBTableComic.allRecords()
        
        if(commics.count>0)
        {
            let sectionTitle = "\(commics.count) comics"
            tableViewSectionsTitle.append(sectionTitle)
            
            // TODO: change to Map with Reduce
            for commic in commics
            {
                sectionItems.append(TableItem(title: commic.title, description: commic.descriptionComic, thumbnail:commic.thumbnail, id: commic.id))
            }
            
            self.tableViewDataSource.append(sectionItems)
        }
        else {
            DLogWarning("No records")
        }
        setViewNeedsToReadInMainTread()
    }
    

}
