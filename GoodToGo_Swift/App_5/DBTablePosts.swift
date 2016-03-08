//
//  GoodToGo_Swift
//
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//


/**
 * Model
 */

import RealmSwift
import Foundation
import UIKit

class DBTablePosts : Object {
    
    /*
    body = "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto";
    id = 1;
    title = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit";
    userId = 1;

     */
    
    dynamic var id     = ""
    dynamic var body   = ""
    dynamic var title  = ""
    dynamic var userId = ""
    
    convenience required init(dic:[String:AnyObject]) {
        self.init()
        self.id     = ToString(dic["id"])
        self.body   = ToString(dic["body"])
        self.title  = ToString(dic["title"])
        self.userId = ToString(dic["userId"])
    }

    static func allRecords() -> Results<DBTablePosts> {
        let realm = try! Realm()
        let result = realm.objects(DBTablePosts)
        return result
    }
    
    static func recordWithRowId(id:String) -> DBTablePosts {
        let realm = try! Realm()
        let result = realm.objects(DBTablePosts).filter("id = \"\(id)\"")
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
        let realm = try! Realm()
        // TODO: Improve
        return realm.objects(DBTablePosts).count
    }
    
    static func deleteAllRecords() -> Int {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(DBTablePosts))
        }
        return 1
    }
    
    deinit { /*DLog("DBTablePosts #\(id) is being deinitialized") */}
}
