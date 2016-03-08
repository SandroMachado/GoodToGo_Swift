//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
//import UIKit

struct  RJSIntrospection
{
    
   /*
    * Dada uma classe, devolve as propriedades que a classe tem
    */
    static func getPropertyList(classToInspect: AnyObject.Type) -> [String]
    {
        var count : UInt32 = 0
        let properties : UnsafeMutablePointer <objc_property_t> = class_copyPropertyList(classToInspect, &count)
        var propertyNames : [String] = []
        let intCount = Int(count)
        for var i = 0; i < intCount; i++
        {
            let property : objc_property_t = properties[i]
            let propertyName = NSString(UTF8String: property_getName(property))!
            propertyNames.append(propertyName as String)
        }
        free(properties)
        return propertyNames
    }
    
    static func getObjectDescription(object:AnyObject) -> NSMutableDictionary?
    {
        if(!HaveValue(object))
        {
            return nil;
        }
   
        let result = NSMutableDictionary();
        let propertyNames = self.getPropertyList(object.dynamicType);
        for propertyName: String in propertyNames
        {
            if(propertyName != "description")
            {
                let value = object.valueForKey(propertyName);
                result.setValue(value, forKey: propertyName);
            }
        }
        return result;
    }
}



