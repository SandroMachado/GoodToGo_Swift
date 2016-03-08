//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import RealmSwift
import Foundation

/*
// (1) Create a Dog object and then set its properties
    var myDog = Dog()
    myDog.name = "Rex"
    myDog.age = 10

// (2) Create a Dog object from a dictionary
    let myOtherDog = Dog(value: ["name" : "Pluto", "age": 3])

// (3) Create a Dog object from an array
    let myThirdDog = Dog(value: ["Fido", 5])
*/

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
    
}
