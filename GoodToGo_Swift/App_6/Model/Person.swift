//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import RealmSwift
import Foundation

// Person model
class DBPerson: Object {
    dynamic var id = 0
    dynamic var name = ""
    
    var aReadyOnlyPropertie: String { // read-only properties are automatically ignored
        return "aReadyOnlyPropertie"
    }
    dynamic var tmpID = 0
    override static func ignoredProperties() -> [String] {
        return ["tmpID"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // Optional int property, defaulting to nil
    // RealmOptional properties should always be declared with `let`,
    // as assigning to them directly will not work as desired
    let age = RealmOptional<Int>()
    
}

