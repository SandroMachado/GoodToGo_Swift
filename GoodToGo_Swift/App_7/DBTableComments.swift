//
//  GoodToGo_Swift
//
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/**
 * Model
 */

/*
import RealmSwift
import Foundation
import UIKit

class DBTableComments : Object {
    
    
    //{
    //body = "est illum quia alias ipsam minus\nut quod vero aut magni harum quis\nab minima voluptates nemo non sint quis\ndistinctio officia ea et maxime";
    //email = "Kadin@walter.io";
    //id = 494;
    //name = "molestias facere soluta mollitia totam dolorem commodi itaque";
    //postId = 99;
    //}

    dynamic var id     = ""
    dynamic var body   = ""
    dynamic var email  = ""
    dynamic var name   = ""
    dynamic var postId = ""
    
    convenience required init(dic:[String:AnyObject]) {
        self.init()
        self.id     = ToString(dic["id"])
        self.body   = ToString(dic["body"])
        self.email  = ToString(dic["email"])
        self.name   = ToString(dic["name"])
        self.postId = ToString(dic["postId"])
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
        return realm.objects(DBTableComments).count
    }
    
    static func deleteAllRecords() -> Int {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(DBTableComments))
        }
        return 1
    }
    
    static func comentsCountFor(postId:String) -> Int {
        let realm = try! Realm()
        let count = realm.objects(DBTableComments).filter("postId = \"\(postId)\"").count
        return count
    }

    
    deinit { /* DLog("DBTableComments #\(id) is being deinitialized") */}

}

*/
