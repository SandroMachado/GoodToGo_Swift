//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

protocol Screen3ViewModelProtocol {
    var latitude: Double { get }
    var longitude: Double { get }
    var viewNeedsReload: Dynamic<Bool> { get }
}

/*
 * ViewModel
 */
final class Screen3ViewModel : Screen3ViewModelProtocol {
    
    var latitude: Double
    var longitude: Double
    
    var viewNeedsReload: Dynamic<Bool>

    init(item:TableItem) {
        self.viewNeedsReload = Dynamic<Bool>(false)

        let record = DBTablePosts.recordWithRowId(item.id)
        let user   = DBTableUsers.recordWithRowId(record.userId)
        
        let adress = user.address
        
        /*
         * Extrate the latitude and longitude using regular expressions
         * Sample In : {city = Gwenborough; geo = {lat = "-37.3159";lng = "81.1496";};street = "Kulas Light";suite = "Apt. 556";zipcode = "92998-3874\;}
         * Sample Out : ["-37.3159", "81.1496"]
         */
        let matches = RJSRegExp.matchesForRegexInText("-?[0-9]{2}[.][0-9]{4}", text: adress)
        
        self.latitude  = RJSConvert.convertToDouble(ToString(matches[0]))
        self.longitude = RJSConvert.convertToDouble(ToString(matches[1]))
        
        if(!RJSUtils.existsInternetConnection()) {
           RJSUtils.postNotificaitonWithName(App7Constants.Notifications.ShowNoInternetConnection)
        }
        
    }
    
}
