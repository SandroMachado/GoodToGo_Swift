//
//  GoodToGo_Swift
//
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/**
 * Model
 */
import RealmSwift
import Foundation
import UIKit

class DBTableUsers : Object {
    /*
    {
        address  = { city = Gwenborough; geo = { lat = "-37.3159"; lng = "81.1496"; };  street = "Kulas Light";  suite = "Apt. 556"; ipcode = "92998-3874"; };
        company  = { bs = "harness real-time e-markets"; catchPhrase = "Multi-layered client-server neural-net"; name = "Romaguera-Crona"; };
        email    = "Sincere@april.biz";
        id       = 1;
        name     = "Leanne Graham";
        phone    = "1-770-736-8031 x56442";
        username = Bret;
        website  = "hildegard.org";
    }
    */

    dynamic var id       = ""
    dynamic var email    = ""
    dynamic var name     = ""
    dynamic var phone    = ""
    dynamic var username = ""
    dynamic var website  = ""
    dynamic var company  = ""
    dynamic var address  = ""
    
    convenience required init(dic:[String:AnyObject]) {
        self.init()
        self.id       = ToString(dic["id"])
        self.email    = ToString(dic["email"])
        self.name     = ToString(dic["name"])
        self.phone    = ToString(dic["phone"])
        self.username = ToString(dic["username"])
        self.website  = ToString(dic["website"])
        self.company  = ToString(dic["company"])
        self.address  = ToString(dic["address"])
    }
    
    static func recordWithRowId(id:Int) -> DBTableUsers {
        let realm = try! Realm()
        let result = realm.objects(DBTableUsers).filter("id = \"\(id)\"")
        return result[0]
    }
    
    func save() -> Int {
        let realm  = try! Realm()
        try! realm.write {
            realm.add(self)
        }
        return 1
    }
    
    static func recordsCount() -> Int {
        // TODO: Improve
        return allRecords().count
    }
    
    static func deleteAllRecords() -> Int {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(DBTableUsers))
        }
        return 1
    }
    
    static func deleteRecordWithId(id:Int) -> Int {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(recordWithRowId(id))
        }
        return 1
    }
    
    static func allRecords() -> Results<DBTableUsers> {
        let realm = try! Realm()
        let result = realm.objects(DBTableUsers)
        return result
    }
    
    deinit { /*DLog("DBTableUsers #\(id) is being deinitialized") */}

}