//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

extension String {
    
    static func base64EncodedString(b64String : String) -> String?
    {
        return b64String.base64EncodedString();
    }
    
    // Dada uma String em PLAIN, converte para BASE_64
    func base64EncodedString() -> String?
    {
        let utf8str = self.dataUsingEncoding(NSUTF8StringEncoding)
        if(!HaveValue(utf8str))
        {
            return nil;
        }
        if let base64Encoded = utf8str?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        {
            if(HaveValue(base64Encoded))
            {
                return base64Encoded;
            }
        }
        return nil;
    }
    
    static func base64DecodedString(aString : String) -> String?
    {
        if(!HaveValue(aString))
        {
            return nil;
        }
        return aString.base64DecodedString()
    }
    
    // Dada uma String em BASE_64, converte para PLAIN
    func base64DecodedString() -> String?
    {
        if let base64Decoded = NSData(base64EncodedString: self, options:   NSDataBase64DecodingOptions(rawValue: 0))
            .map({ NSString(data: $0, encoding: NSUTF8StringEncoding) })
        {
            if(HaveValue(base64Decoded))
            {
                return base64Decoded as? String;
            }
        }
        return nil;
    }
    
}