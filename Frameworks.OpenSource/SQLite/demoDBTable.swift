//
//  Category.swift
//  SQLiteDB-iOS
//
//  Created by Fahim Farook on 6/11/15.
//  Copyright © 2015 RookSoft Pte. Ltd. All rights reserved.
//

import UIKit

class DemoDBTable : RJSSQLiteDB, RJSSQLiteDBProtocol {

    var rowId  = 0

	var someCol = ""
    var otherCol = ""
    
    let externalTableName = "DemoDBTable"
    func sqliteTableName() -> String  {
        return externalTableName
    }
    
    override func initWithDic(dic:[String:AnyObject]) {
        assert(false)
    }
    
    init() {
        super.init(tableName:externalTableName)
    }
    
    required convenience init(tableName:String) {
        self.init()
    }
    
}
