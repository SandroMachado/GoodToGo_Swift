//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

// https://www.natashatherobot.com/swift-unwrap-multiple-optionals/

struct LOptionals
{
    
    static func unwrappMultipleOptional(optional1:String?, optional2:String?) -> String {
        switch(optional1, optional2) {
            case let (.Some(optional1), .Some(optional2)):
                return "\(optional1) and \(optional2)"
            case let (.Some(optional1), .None):
                return "just \(optional1))"
            case let (.None, .Some(optional2)):
                return "just \(optional2))"
            case (.None, .None):
                return "just \(optional2))";
        }
    }
    
    static func start () -> Void
    {
        print(unwrappMultipleOptional(nil, optional2: "aaaa"))
        print(unwrappMultipleOptional("bbbb", optional2: "aaaa"))
        print(unwrappMultipleOptional(nil, optional2: nil))

    }
}


