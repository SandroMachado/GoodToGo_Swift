//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol RJSSQLiteDBProtocol {
    
    /**
     * var externalTableName = "tasks"
     * func sqliteTableName() -> String {
     *    return externalTableName
     * }
     *
     * func initWithDic(dic:[String:AnyObject]) {
     *    assert(false)
     * }
     */
    func initWithDic(dic:[String:AnyObject])
    var externalTableName : String { get }
    func sqliteTableName() -> String
    
    
}

class RJSSQLiteDB : SQLTable {

    private var rowId = -1 // To be overriden

    // MARK: Private
    
    private static func getValideInstanceObject() -> AnyObject
    {
        // Find the class
        let className   = String(self)
        let ns          = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let anyDbObject = (NSClassFromString(ns + "." + className)! as! RJSSQLiteDB.Type).init(tableName: "")
    
        let implementsTableName = anyDbObject.respondsToSelector(Selector("sqliteTableName"))
        if(implementsTableName)
        {
            let tableName1    = anyDbObject.performSelector(Selector("sqliteTableName"))
            let tableName2    = tableName1.takeRetainedValue() as! String
            anyDbObject.table = tableName2;
        }
        else
        {
            DLogWarning("Object does not implements sqliteTableName")
        }
        return anyDbObject;
    }
    
    private static func dbResponseToInt(response:[[String:AnyObject]])->Int
    {
        guard response.count==1 else  {
            return -1
        }
        
        let firstValue = response[0].values.first
        if firstValue != nil{
            return firstValue!.integerValue
        }
        return -1;
    }
    
    // MARK: Utils
    
    func initWithDic(dic:[String:AnyObject])
    {
        DLogError("Override in sub-classe!")
        assert(false)
    }
    
    // MARK: Public

    func recordsCount(queryWhere:String="") -> Int
    {
        let instanceObject = self
        guard !instanceObject.table.isEmpty else
        {
            DLogWarning("Ignored")
            return -1
        }
        let db  = SQLiteDB.sharedInstance()
        var sql = "SELECT COUNT(*) AS result FROM \(instanceObject.table)"
        if !queryWhere.isEmpty {
            sql += " WHERE \(queryWhere) COLLATE NOCASE"
        }
        //print(sql)
        let result = RJSSQLiteDB.dbResponseToInt(db.query(sql))
        return result
    }
    
    func saveRecord() -> Int
    {
        let result = self.save()
        if result.success
        {
            self.rowId = result.id
        }
        return self.rowId
    }
    
    static func deleteRecordWithId(rowId:Int) -> Bool
    {
        let instanceObject = getValideInstanceObject() as! RJSSQLiteDB
        instanceObject.rowId = rowId
        return instanceObject.deleteRecord()
    }
    
    func deleteRecord() -> Bool
    {
        var result = false
        guard !table.isEmpty else
        {
            DLogWarning("Ignored")
            return false
        }
        let db         = SQLiteDB.sharedInstance()
        let primaryKey = self.primaryKey()
        let sql        = "DELETE FROM \(table) WHERE \(primaryKey)=\(rowId)"
        result         = db.execute(sql)>0
        return result
    }
    
    func recordWithRowId(rowId:Int) -> AnyObject?
    {
        let primaryKey    = self.primaryKey()
        let queryWhere    = "\(primaryKey)=\(rowId)"
        let partialResult = self.recordsWhere(queryWhere, order:"")
        if(partialResult.count==1)
        {
            return partialResult.first
        }
        return nil
    }
    
    func allRecords() -> [AnyObject]
    {
        let records = self.recordsWhere("", order:"")
        return records
    }
    
    func recordsWhere(queryWhere:String="", order:String="") -> [AnyObject] {
        guard !table.isEmpty else
        {
            DLogWarning("Ignored")
            return [AnyObject]()
        }

        let db   = SQLiteDB.sharedInstance()
        var sql  = "SELECT * FROM \(table)"
        if !queryWhere.isEmpty {
            sql += " WHERE  \(queryWhere)"
        }
        if !order.isEmpty {
            sql += " ORDER BY \(order)"
        }
        
        let rows = db.query(sql)
        return rows;
        
    }
    

    func descriptionSQLiteObject() -> String
    {
        return "\(RJSIntrospection.getObjectDescription(self))"
    }
}