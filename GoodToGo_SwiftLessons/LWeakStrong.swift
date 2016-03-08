//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

// Article : http://krakendev.io/blog/weak-and-unowned-references-in-swift


struct LWeakStrong
{
    static func start () -> Void
    {
        /*
        class Person {
            let name: String
            init(name: String) { self.name = name }
            var apartment: Apartment?
            deinit { print("\(name) is being deinitialized") }
        }
        
        class Apartment {
            let number: Int
            init(number: Int) { self.number = number }
            weak var tenant: Person?
            deinit { print("Apartment #\(number) is being deinitialized") }
        }
        */
        

        /*
        
        STRONG :In essence, as long as anything has a strong reference to an object, it will not be deallocated.
        
        Here we have a linear hierarchy at play. Kraken has a strong reference to a Tentacle instance which has a strong reference to a Sucker instance. The flow goes from Parent (Kraken) all the way down to child (Sucker).
        
     
        class Sucker {}
        
        class Tentacle {
            let sucker = Sucker() //strong reference to child
        }
        
        class Kraken {
            let tentacle = Tentacle() //strong reference to child.
        }
        

        A weak reference is just a pointer to an object that doesn't protect the object from being deallocated by ARC. While strong references increase the retain count of an object by 1, weak references do not. In addition, weak references zero out the pointer to your object when it successfully deallocates. This ensures that the when you access a weak reference, it will either be a valid object, or nil.
        
        In Swift, all weak references are non-constant Optionals (think var vs. let) because the reference can and will be mutated to nil when there is no longer anything holding a strong reference to it.
*/
        

    }
}




