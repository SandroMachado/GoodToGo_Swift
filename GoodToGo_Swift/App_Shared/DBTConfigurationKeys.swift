//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//


class DBTConfigurationKeys:RJSSQLiteDB {
    
    var id = -1
    var key = ""
    var value = ""
    var lastChangedDate = ""

    let externalTableName = "ConfigurationKeys"
    
    init()
    {
        super.init(tableName:externalTableName)
    }
    
    required convenience init(tableName:String) {
        self.init()
    }
}

