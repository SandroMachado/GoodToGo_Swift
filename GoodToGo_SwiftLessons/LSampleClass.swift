//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation



struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

class Counter
{
    var count = 0
    func increment()
    {
        ++count
    }
    func incrementBy(amount: Int)
    {
        count += amount
    }
    func reset()
    {
        count = 0
    }
}

class StepCounter
{
    var totalSteps: Int = 0
        {
        willSet(newTotalSteps)
        {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet
        {
            if totalSteps > oldValue
            {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
        
    static func sample() -> Void
    {
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
    }
        
}

