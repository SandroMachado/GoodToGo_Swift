//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
//import UIKit

extension String {
    
    static func getPlainString(input:[UInt8]) -> String {
        return ToString(NSString(bytes: input, length: input.count, encoding: NSASCIIStringEncoding))
    }
    
    static func randomStringWithLength (len : Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString as String
    }
    
    func replace(oldString:String, with:String) -> String {
        guard !oldString.isEmpty else {
            DLogWarning("Do you want to replace an empty char?")
            return self
        }
        let newString = self.stringByReplacingOccurrencesOfString(oldString, withString: with)
        return newString
    }
    
    func countUTF8() -> Int
    {
        return self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
    
    func count()-> Int
    {
        if(!HaveValue(self))
        {
            return 0;
        }
        let result = self.characters.count
        return result;
    }
    
    func trim()-> String
    {
        if(!HaveValue(self))
        {
            return "";
        }
        let result = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        return result;
    }
    
    func containsString(string:String) -> Bool
    {
        return self.lowercaseString.rangeOfString(string.lowercaseString) != nil
    }
    
    func cleanString() -> String
    {
        return String.cleanString(self);
    }
    
    func splitByChar(demiliter:String)->[String]
    {
        if(HaveValue(demiliter))
        {
            if(demiliter.countUTF8()>1)
            {
                DLogWarning("O delimitador [\(demiliter)] deveria ter tamanho 1.")
            }
            let firstChar = demiliter.characters.first;
            let splited   = self.characters.split{$0 == firstChar}.map(String.init)
            return splited;
        }
        return []
    }
    
    // In  -> Optional(Optional(https://www.google.com))
    // Out -> https://www.google.com
    static func cleanString(stringIn : String)->String
    {
        var stringOut = stringIn;
        let trash     = "Optional(";
        let trashLen  = trash.characters.count;
        while(stringOut.hasPrefix(trash))
        {
            stringOut = stringOut.substringFromIndex(stringOut.startIndex.advancedBy(trashLen))
            // Remover o ultimo ')'
            stringOut = String(stringOut.characters.dropLast())
        }
        
        if(stringOut.hasPrefix("\"") && stringOut.hasSuffix("\""))
        {
            stringOut = String(stringOut.characters.dropLast())
            stringOut = String(stringOut.characters.dropFirst())
        }
        
        if(stringOut == "nil")
        {
            stringOut = "";
        }
        stringOut = stringOut.trim()
        return stringOut;
    }
    
    static func isNullOrEmpty(aString : AnyObject?) -> Bool
    {
        if(!HaveValue(aString))
        {
            return true;
        }
        if (aString as! String).trim().isEmpty
        {
            return true;
        }
        if (aString as! String).count()==0
        {
            return true;
        }
        return false;
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        // Decode B64
        assert(String.base64DecodedString("dGVzdGU=")=="teste")
        
        // Enconde B64
        assert("teste".base64EncodedString()=="dGVzdGU=")
        assert(String.base64EncodedString("teste")=="dGVzdGU=")
        
        assert(String.isNullOrEmpty(""));
        assert(String.isNullOrEmpty(nil));
        assert("".trim() == "")
        assert(" ".trim() == "")
        assert(" . ".trim() == ".")
        
        assert(String.cleanString("Optional(Optional(https://www.google.com))")=="https://www.google.com")
        assert(String.cleanString("https://www.google.com")=="https://www.google.com")
        assert("olá adeus".splitByChar(" ").last == "adeus")
        assert("olá adeus 123".splitByChar(" ").count == 3)

    }
}