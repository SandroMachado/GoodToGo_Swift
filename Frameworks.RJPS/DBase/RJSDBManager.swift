//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import RealmSwift

enum RJSDBManagerConstants {
    static var FileName: String {
        return "AppSqlite3DB.db"
    }
    static var DataBaseTemplate: String {
        return "SQLiteTemplateDB.bd"
    }
}

struct RJSDBManager
{
    // MARK: Realm
    struct Realm
    {
        static func saveObject(objectToSave:Object) -> Int {
            return 1
        }
        
        static func deleteDB() -> Bool
        {
         //   RJSFilesManager.clearFolder(.Documents)
         //   let realm = try! Realm()
         //   realm.beginWrite()
         //   realm.deleteAll()
          //  try! realm.commitWrite()
            
         /*   RJSFilesManager.clearFolder(.Documents)
            let realm = try! Realm()
            realm.beginWrite()
            realm.deleteAll()
            try! realm.commitWrite()
            return true*/
            return false
        }
    }
    
    // MARK: RJSDBManagerQueries
    struct RJSDBManagerQueries
    {
        static func recordWithId(dbName:String, tableName:String, recordId:String) -> String
        {
            return "SELECT * FROM \(tableName) WHERE id='\(recordId)';"
        }
        
        static func tableExistsInDatabase(dbName:String, tableName:String) -> String
        {
            return "SELECT * FROM sqlite_master WHERE type='table' and name = '\(tableName)'"
        }
        
        static func dumpBDInfo() -> String
        {
            return "SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_%%';"
        }
        
        static func dumpTableInfo(tableName:String) -> String
        {
            return "PRAGMA table_info(\(tableName))"
        }
        
        static func createTable(tableName:String, primaryKey:String) -> String
        {
            guard !primaryKey.isEmpty else
            {
                DLogError("Invalid primary key name")
                return ""
            }
            return "CREATE TABLE \(tableName)(\(primaryKey) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL );"
        }
        
        static func dropTable(tableName:String) -> String
        {
            return "DROP TABLE \(tableName);"
        }
        
        static func deleteRecords(tableName:String, recordsWere:String="WHERE 1=1") -> String
        {
            return "DELETE FROM \(tableName) \(recordsWere);"
        }
        
        static func addCollToTable(tableName:String, colName:String, colType:String, allowNulls:Bool=false) -> String
        {
            guard colType=="TEXT" || colType=="INT" else
            {
                DLogError("Invalid colType: \(colType)")
                return ""
            }
            return "ALTER TABLE \(tableName) ADD COLUMN \(colName) \(colType)"
        }
        
    }
    
    // MARK: Utils
    struct Utils
    {
        static func dumpDataBaseInfo(dbName:String, logValue:Bool=false) -> String
        {
            let db = SQLiteDB.sharedInstance("", dbFileName: dbName)
            let result = db.query(RJSDBManagerQueries.dumpBDInfo());
            if(logValue)
            {
                DLog("DataBase [\(dbName)] info: \(result)")
            }
            return "\(result)"
        }
        
        static func dumpTableInfo(dbName:String, tableName:String, logValue:Bool=false) -> String
        {
            let db = SQLiteDB.sharedInstance("", dbFileName: dbName)
            let result = db.query(RJSDBManagerQueries.dumpTableInfo(tableName));
            if(logValue)
            {
                DLog("Table [\(tableName)] info: \(result)")
            }
            return "\(result)"
        }
        
        static func createTable(dbName:String, tableName:String, primaryKey:String) -> Bool
        {
            guard !self.tableExistsInDatabase(dbName, tableName: tableName) else {
                DLogWarning("Table \(tableName) does allready exists in \(dbName)")
                return false
            }
            let db = SQLiteDB.sharedInstance("", dbFileName: dbName)
            let result = db.execute(RJSDBManagerQueries.createTable(tableName, primaryKey: primaryKey));
            return result==1
        }
        
        static func addCollToTable(dbName:String, tableName:String, colName:String, colType:String) -> Bool
        {
            guard self.tableExistsInDatabase(dbName, tableName: tableName) else {
                DLogWarning("Table \(tableName) does not exists in \(dbName)")
                return false
            }
            let db = SQLiteDB.sharedInstance("", dbFileName: dbName)
            let result = db.execute(RJSDBManagerQueries.addCollToTable(tableName, colName: colName, colType: colType));
            return result==1
        }
        
        static func deleteAllRecordFromTable(dbName:String, tableName:String) -> Bool
        {
            guard self.tableExistsInDatabase(dbName, tableName: tableName) else {
                DLogWarning("Table \(tableName) does not exists in \(dbName)")
                return false
            }
            let db = SQLiteDB.sharedInstance("", dbFileName: dbName)
            let result = db.execute(RJSDBManagerQueries.deleteRecords(tableName));
            return result==1
        }
        
        static func dropTable(dbName:String, tableName:String) -> Bool
        {
            guard self.tableExistsInDatabase(dbName, tableName: tableName) else {
                DLogWarning("Table \(tableName) does not exists in \(dbName)")
                return false
            }
            let db = SQLiteDB.sharedInstance("", dbFileName: dbName)
            let result = db.execute(RJSDBManagerQueries.dropTable(tableName));
            return result==1
        }
        
        static func tableExistsInDatabase(dbName:String, tableName:String) -> Bool
        {
            let db = SQLiteDB.sharedInstance("", dbFileName: dbName)
            let result = db.query(RJSDBManagerQueries.tableExistsInDatabase(dbName, tableName: tableName));
            return result.first != nil
        }
    }
    
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        let templateDB   = "demoDB.db";
        let testingTable = DemoDBTable().table;
        
        /**
        * Database general testing
        */
        
        if(RJSDBManager.Utils.tableExistsInDatabase(templateDB, tableName: testingTable))
        {
            RJSDBManager.Utils.dropTable(templateDB, tableName: testingTable)
        }
        
        let dbInfo1 = RJSDBManager.Utils.dumpDataBaseInfo(templateDB)
        assert(!dbInfo1.isEmpty)
        
        // Test - Create Table
        assert(RJSDBManager.Utils.createTable(templateDB, tableName: testingTable, primaryKey: "rowId"))
        
        // Test - Check If Table Exists 1
        assert(!RJSDBManager.Utils.tableExistsInDatabase(templateDB, tableName: "ThisTableDoesNotExists"))
        
        // Test - Check If Table Exists 2
        assert(RJSDBManager.Utils.tableExistsInDatabase(templateDB, tableName: testingTable))
        
        // Test - Drop Table
        assert(RJSDBManager.Utils.dropTable(templateDB, tableName: testingTable))
        
        /**
        * Table functions general testing
        */
        
        SQLiteDB.sharedInstance("", dbFileName:templateDB )
        
        // Create the table and add the missing fields
        let primaryKey = RJSSQLiteDB(tableName: "").primaryKey()
        RJSDBManager.Utils.createTable(templateDB, tableName: testingTable, primaryKey: primaryKey)
        RJSDBManager.Utils.addCollToTable(templateDB, tableName: DemoDBTable().table, colName: "someCol", colType: "TEXT")
        RJSDBManager.Utils.addCollToTable(templateDB, tableName: DemoDBTable().table, colName: "otherCol", colType: "TEXT")
        
        let record = DemoDBTable()
        record.someCol  = "someCol"
        record.otherCol = "otherCol"
        
        // Test - Insert
        assert(record.saveRecord()>0)
        
        // Test - rowId auto-update after insert
        assert(record.rowId==1)
        
        // Test - Records Count
        assert(DemoDBTable().recordsCount()==1)
        
        let rowId = record.rowId
        
        // Test - Fetch Inserted Record
        var recordWithRowId = DemoDBTable().recordWithRowId(rowId) as! DemoDBTable
        assert(recordWithRowId.rowId==rowId)
        assert(recordWithRowId.someCol=="someCol")
        assert(recordWithRowId.otherCol=="otherCol")
        
        // Test - Update
        let newColValue = "lowerEpsilon"
        record.someCol  = newColValue
        record.otherCol = newColValue
        assert(record.saveRecord()==rowId)
        
        // Test - Fetch Updated Record
        recordWithRowId = DemoDBTable().recordWithRowId(rowId) as! DemoDBTable
        assert(recordWithRowId.rowId==1)
        assert(recordWithRowId.someCol==newColValue)
        assert(recordWithRowId.otherCol==newColValue)
        
        // Test - Delete record
        assert(DemoDBTable.deleteRecordWithId(recordWithRowId.rowId))
        assert(recordWithRowId.deleteRecord())
        assert(DemoDBTable().recordsCount()==0)
        let deletedRecord = DemoDBTable().recordWithRowId(rowId)
        assert(deletedRecord==nil)
        
        // Drop the test table
        RJSDBManager.Utils.dropTable(templateDB, tableName: testingTable)
        
    }
}
