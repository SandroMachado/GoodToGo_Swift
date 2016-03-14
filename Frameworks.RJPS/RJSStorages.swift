//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import Locksmith

struct  RJSStorages
{
   
    // MARK: - NSUserDefaults
    /**
     @brief Delete from NSUserDefaults the value for the key
     @param key is the key of the object to be deleted.
     @warning No warnings
     @return Void
     */
    static func deleteFromDefaults(key : String) -> Bool
    {
        guard !key.isEmpty else {
            DLogWarning("Ignored. Invalid key")
            return false
        }
        return saveToDefaults(nil, key: key)
    }
    
    /**
     @brief Save to NSUserDefaults the value for the key
     @param key is the key of the object to be saved.
     @param objectToSave is the object that will be saved
     @warning Only tested with String's
     @return Void
     */
    static func saveToDefaults(objectToSave : AnyObject?, key : String) -> Bool
    {
        guard !key.isEmpty else {
            DLogWarning("Ignored. Invalid key")
            return false
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(objectToSave, forKey: key)
        return true
    }
    
    /**
     @brief Read from NSUserDefaults the value for the key
     @param key is the key of the object to be readed.
     @warning Only tested with String's
     @return Void
     */
    static func readFromDefaults(key : String?) -> AnyObject?
    {
        if(!HaveValue(key))
        {
            return nil
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        if let object = defaults.objectForKey(key!)
        {
            return object
        }
        return nil;
    }
    
    // MARK: - Keychain
    private static let keychainGroup = "rjps.app.keychain"
    static func saveToKeychain(value : String, key : String) -> Bool
    {
        guard !key.isEmpty else {
            DLogWarning("Ignored. Invalid key")
            return false
        }
        
        _ = try! Locksmith.saveData([key: value], forUserAccount: keychainGroup)
        
        return true
    }
    
    static func readFromKeychain(key : String) -> String?
    {
        guard !key.isEmpty else {
            DLogWarning("Ignored. Invalid key")
            return nil
        }
        
        let dictionary = Locksmith.loadDataForUserAccount(keychainGroup)
        let result = dictionary?.valueForKey(key)
        if(HaveValue(result)) {
            return ToString(result)
        }
        return ""
    }
    
    // MARK: - Keychain

    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        // Save test
        let defaultsKey = "someKey"
        assert(saveToDefaults("some string", key: defaultsKey))
        assert(HaveValue(readFromDefaults(defaultsKey)))
                
        // Delete test
        assert(saveToDefaults(nil, key: defaultsKey))
        assert(!HaveValue(readFromDefaults(defaultsKey)))

    }
}



