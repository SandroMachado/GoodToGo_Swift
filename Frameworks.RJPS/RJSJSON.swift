//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

struct RJSJSON
{
    // TODO: Use Swiftify    
    // Given some object (NSData ou NSString), extracts to JSON, and then to AnyObject (Array, dic, etc)
    static func convertObjectToJSONToObject(obj: AnyObject?, handleError: Bool = true) -> AnyObject?
    {
        var data: NSData? = nil
        var result: AnyObject? = nil
        if let aux = obj as? String
        {
            data = aux.dataUsingEncoding(NSUTF8StringEncoding)!
        }
        else if let aux = obj as? NSData
        {
            data = aux
        }
        else if let aux = obj as? NSDictionary
        {
            return aux
        }
        else {
            DLogWarning("Not predicted!")
        }
        
        guard HaveValue(data) else {
            DLogWarning("Ignored...")
            return nil
        }
        
        if (NSJSONSerialization.isValidJSONObject(data!) || true)
        {
            do
            {
                let fetchedEntities = try  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                result = fetchedEntities;
            }
            catch let ex as NSError
            {
                if(handleError)
                {
                    RJSExceptionsManager.handleException(ex)
                }
            }
        }
        return result;
    }
    
    static func isJSON(obj: AnyObject?) -> Bool
    {
        return HaveValue(convertObjectToJSONToObject(obj, handleError: false))
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        assert(isJSON("{\"id\": 1,\"name\": \"A green door\",\"price\": 12.50,\"tags\": [\"home\", \"green\"]}"))
        assert(!isJSON("{maria}"))
    }
    
}


