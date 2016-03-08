//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

struct LIterators
{
    static func start () -> Void
    {
       /*
        * FOR
        */
        
        //////// SAMPLE 1 ////////
        //////// SAMPLE 1 ////////
        //////// SAMPLE 1 ////////
        
        let names1 = ["Anna", "Alex", "Brian", "Jack"]
        let count = names1.count
        for i in 0..<count
        {
            print("Person \(i + 1) is called \(names1[i])")
        }
        // Person 1 is called Anna
        // Person 2 is called Alex
        // Person 3 is called Brian
        // Person 4 is called Jack
        
        //////// SAMPLE 2 ////////
        //////// SAMPLE 2 ////////
        //////// SAMPLE 2 ////////
        
        for index in 1...5
        {
            print("\(index) times 5 is \(index * 5)")
        }
        // 1 times 5 is 5
        // 2 times 5 is 10
        // 3 times 5 is 15
        // 4 times 5 is 20
        // 5 times 5 is 25
        
        //////// SAMPLE 3 ////////
        //////// SAMPLE 3 ////////
        //////// SAMPLE 3 ////////
        
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power
        {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        // prints "3 to the power of 10 is 59049"
        
        //////// SAMPLE 4 ////////
        //////// SAMPLE 4 ////////
        //////// SAMPLE 4 ////////
        
        let names2 = ["Anna", "Alex", "Brian", "Jack"]
        for name in names2
        {
            print("Hello, \(name)")
        }
        
        //////// SAMPLE 5 ////////
        //////// SAMPLE 5 ////////
        //////// SAMPLE 5 ////////
        
        for var index = 0; index < 3; ++index
        {
            print("index is \(index)")
        }
        // index is 0
        // index is 1
        // index is 2
    }
}

