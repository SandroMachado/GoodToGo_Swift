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

class DBTableComic : Object {
    
    dynamic var id       = ""
    dynamic var digitalId    = ""
    dynamic var title     = ""
    dynamic var issueNumber    = ""
    dynamic var variantDescription = ""
    dynamic var descriptionCommic  = ""
    dynamic var thumbnail  = ""
    dynamic var images  = ""
    dynamic var format  = ""
    dynamic var pageCount  = ""
    dynamic var resourceURI  = ""
    
    /// TODO: Delete latter
    dynamic var originalJSON  = "" // Just in case?
    
    convenience required init(dic:[String:AnyObject]) {
        self.init()
        self.id                 = ToString(dic["id"])
        
        self.title              = ToString(dic["title"])
        self.digitalId          = ToString(dic["digitalId"])
        self.issueNumber        = ToString(dic["issueNumber"])
        self.descriptionCommic  = ToString(dic["description"])
        let thumbnailAux        = dic["thumbnail"]
        self.thumbnail          = "\(ToString(thumbnailAux!["path"])).\(ToString(thumbnailAux!["extension"]))"
        self.variantDescription = ToString(dic["variantDescription"])
        self.images             = ToString(dic["images"])
        self.format             = ToString(dic["pageCount"])
        self.format             = ToString(dic["pageCount"])
        self.resourceURI        = ToString(dic["resourceURI"])
        self.originalJSON       = ToString(dic)
    }
    
    static func recordWithRowId(id:String) -> DBTableComic {
        let realm = try! Realm()
        let result = realm.objects(DBTableComic).filter("id = \"\(id)\"")
        return result[0]
    }
    
    func save() -> Int {
        let realm  = try! Realm()
        try! realm.write {
            realm.add(self)
        }
        return 1
    }
    
    static func allRecords() -> Results<DBTableComic> {
        let realm = try! Realm()
        let result = realm.objects(DBTableComic)
        return result
    }
    
    static func recordsCount() -> Int {
        let realm = try! Realm()
        // TODO: Improve
        return realm.objects(DBTableComic).count
    }
    
    static func deleteAllRecords() -> Int {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(DBTableComic))
        }
        return 1
    }
    
    deinit { /*DLog("DBTableUsers #\(id) is being deinitialized") */}

}