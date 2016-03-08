//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation


struct LClosures
{
    
    static func start () -> Void
    {
        let yyy = { print("123") }
        let xxx: String -> Int = { Int($0)! }
        let zzz: String -> Void = { print($0) }
        
        yyy()
        print(xxx("1"))
        zzz("2")

    }
}


