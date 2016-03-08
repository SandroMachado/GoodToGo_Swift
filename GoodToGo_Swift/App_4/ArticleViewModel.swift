//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/*
 * The view model protocol defines input exactly in the types the view needs.
 *
 * the view model protocol defines input exactly in the types the view needs. 
 * All properties are of String type. Date is String because date label expects
 * String on its input. Also note that we're requiring only getters for the properties
 * - we'll not be setting any of them from the view controller.
 */
protocol ArticleViewModelProtocol {
    var title: String { get }
    var date: String { get }
    var thumbnail: UIImage? { get }
    var viewNeedsReload: Dynamic<Bool> { get }
}

/*
 * ViewModel
 */
class ArticleViewModel : ArticleViewModelProtocol {
    var title: String
    var date: String
    var thumbnail: UIImage?
    var viewNeedsReload: Dynamic<Bool>

    var tableViewSectionsTitle:[String] = []
    var tableViewDataSource:[[TableItem]] = []
    
    let article: Article

    init(_ article: Article) {
        self.article            = article
        self.title              = article.title
        self.thumbnail          = article.image
        self.viewNeedsReload    = Dynamic<Bool>(false)
        let dateFormatter       = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        self.date               = dateFormatter.stringFromDate(article.date)
        
        let imageURL = "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png"
        RJSDownloadsManager.downloadImage(imageURL) { (result, error) -> Void in
            if(HaveValue(error)) {
                RJSErrorsManager.handleError(error)
            }
            else {
                self.thumbnail = result
                self.viewNeedsReload.value = true;
            }
        }
    }
    
    func makeSomeOperation()
    {
        self.date                  = ToString(NSDate())
        self.viewNeedsReload.value = true;
    }
    
    func reloadTableViewData()
    {
        tableViewSectionsTitle.removeAll()
        tableViewDataSource.removeAll()
        
        // Generate random table
        for sectionNumber in 0..<RJSUtils.randomInt(1, max: 5) {
            let sectionTitle = "Section \(sectionNumber)"
            tableViewSectionsTitle.append(sectionTitle)
            var sectionItems = [TableItem]()
            for _ in 0..<RJSUtils.randomInt(1, max: 5) {
                sectionItems.append(TableItem(title: String.randomStringWithLength(5), description: ""))
            }
            tableViewDataSource.append(sectionItems)
        }
        
        self.viewNeedsReload.value = true;

    }
}
