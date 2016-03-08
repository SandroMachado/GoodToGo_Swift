//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
    
    func valueForKey(key : String)-> AnyObject?
    {
        if(!HaveValue(key))
        {
            return nil;
        }
                
        for (k, value) in self
        {
            if(k as! String)==key
            {
                return value as? AnyObject;
            }
        }
        
        return nil/// ;
    }
    
    static func samples() -> Void
    {
        var namesOfIntegers = [Int: String]()
        namesOfIntegers[16] = "sixteen"
        
        let airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        // Iterar
        for (airportCode, airportName) in airports
        {
            print("\(airportCode): \(airportName)")
        }
        
    }
    
}

