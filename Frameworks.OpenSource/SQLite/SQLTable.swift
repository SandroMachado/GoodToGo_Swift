//
//  SQLTable.swift
//  SQLiteDB-iOS
//
//  Created by Fahim Farook on 6/11/15.
//  Copyright © 2015 RookSoft Pte. Ltd. All rights reserved.
//

import UIKit

extension SQLTable
{
    static func isValidKey(key:String)->Bool
    {
        if(key.hasPrefix("external"))
        {
            return false
        }
        return true
    }
}

class SQLTable : NSObject {

    private var rowId = -1 // To be overriden
    var table = "" // To be overriden
    
	private var data:[String:AnyObject]!
    
	required init(tableName:String) {
		super.init()
        
        switch self {
            case _ as RJSSQLiteDBProtocol:
                // Cool...
                break
            default:
            DLogError("Object does not implements RJSSQLiteDBProtocol")
            break
        }
		table = tableName
	}
	
	func primaryKey() -> String {
		return "rowId"
	}
    
    @available(iOS, deprecated=1.0, message="Use insted DBTableSomeTable.allRecords()")
	func allRows<T:SQLTable>(order:String="") -> [T] {
        DLogWarning("Dont use this!")
		var res = [T]()
		self.data = values()
		let db = SQLiteDB.sharedInstance()
		var sql = "SELECT * FROM \(table)"
		if !order.isEmpty {
			sql += " ORDER BY \(order)"
		}
		let arr = db.query(sql)
        
        let properties = T(tableName:table).properties()
		for row in arr {
			let t = T(tableName:table)
			for (key, _) in data {
                if(!SQLTable.isValidKey(key))
                {
                    continue;
                }
                if(properties.contains(key))
                {
                    let val = row[key]
                    t.setValue(val, forKey:key)
                }
                else
                {
                    DLogWarning("The class \(t) is not key value complient with [\(key)]")
                }
			}
			res.append(t)
		}
		return res
	}
	
    func properties() -> [String] {
		var res = [String]()
		for c in Mirror(reflecting:self).children {
			if let name = c.label{
				res.append(name)
			}
		}
		return res
	}
	
    func values() -> [String:AnyObject] {
		var res = [String:AnyObject]()
		let obj = Mirror(reflecting:self)
		for (_, attr) in obj.children.enumerate() {
			if let name = attr.label {
				res[name] = getValue(attr.value as! AnyObject)
			}
		}
		return res
	}
	
    func getValue(val:AnyObject) -> AnyObject {
		if val is String {
			return val as! String
		} else if val is Int {
			return val as! Int
		} else if val is Float {
			return val as! Float
		} else if val is Double {
			return val as! Double
		} else if val is Bool {
			return val as! Bool
		} else if val is NSDate {
			return val as! NSDate
		}
		return "nAn"
	}
	
    func getSQL(forInsert:Bool = true) -> (String, [AnyObject]?) {
		var sql = ""
		var params:[AnyObject]? = nil
		if forInsert {
			// INSERT INTO tasks(task, categoryID) VALUES ('\(txtTask.text)', 1)
			sql = "INSERT INTO \(table)("
		} else {
			// UPDATE tasks SET task = ? WHERE categoryID = ?
			sql = "UPDATE \(table) SET "
		}
		let pkey = primaryKey()
		var wsql = ""
		var rid:AnyObject?
		var first = true
        var primaryKeyWasFound = false
		for (key, val) in data {
            if(!SQLTable.isValidKey(key)) {
                continue;
            }
			// Primary key handling
			if pkey == key {
				if forInsert {
					if val is Int && (val as! Int) == -1 {
						// Do not add this since this is (could be?) an auto-increment value
                        primaryKeyWasFound = true
						continue
					}
				} else {
					// Update - set up WHERE clause
					wsql += " WHERE " + key + " = ?"
					rid = val
                    primaryKeyWasFound = true
					continue
				}
			}
			// Set up parameter array - if we get here, then there are parameters
			if first && params == nil {
				params = [AnyObject]()
			}
			if forInsert {
				sql += first ? key : "," + key
				wsql += first ? " VALUES (?" : ", ?"
				params!.append(val)
			} else {
				sql += first ? key + " = ?" : ", " + key + " = ?"
				params!.append(val)
			}
			first = false
		}
		// Finalize SQL
		if forInsert {
			sql += ")" + wsql + ")"
		} else if params != nil && !wsql.isEmpty {
			sql += wsql
			params!.append(rid!)
		}
        
        // Check if we really found the primary key (in the update case)
        if(!primaryKeyWasFound && !forInsert) {
            DLogWarning("Fail to found the primary key [\(pkey)] in [\(data)]. The update may not work or be dangerous")
        }
		return (sql, params)
	}
    
    func save() -> (success:Bool, id:Int) {
        assert(!table.isEmpty, "You should define the table name in the sub-class")
        
        let db    = SQLiteDB.sharedInstance()
        self.data = values()
        var insert = true
        if(rowId>=0)
        {
            let sql = "SELECT COUNT(*) AS count FROM \(table) WHERE \(primaryKey())=\(rowId)"
            let arr = db.query(sql)
            if arr.count == 1 {
                if let cnt = arr[0]["count"] as? Int {
                    insert = (cnt == 0)
                }
            }
        }

        // Insert or update
        let (sql, params) = getSQL(insert)
        let rc            = db.execute(sql, parameters:params)
        let res           = (rc != 0)
        if !res {
            DLogError("Error saving record!")
        }
        else {
            if(insert) {
                DLog("New record saved with id:\(rc)")
            }
            else {
                DLog("Record updated with id:\(rc)")
            }
        }
        return (res, Int(rc))
    }
}
