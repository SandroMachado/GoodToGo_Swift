//
//  GoodToGo_Swift
//
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/**
 * Model
 */

class Article: NSObject {
    let title : String
    let date  : NSDate
    let image : UIImage
    
    init(title: String="", date: NSDate=NSDate(), image: UIImage=UIImage()) {
        self.date  = date
        self.title = title
        self.image = image
    }
}