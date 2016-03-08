//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

//
// http://code.tutsplus.com/tutorials/how-to-use-generics-in-swift--cms-24919
//

protocol Healthy {
    mutating func setAlive(status: Bool)
    var health: Int { get }
}

struct LGenerics
{
    
    /*
    Here we see the syntax of using generics. The generic types are symbolized by T and E. 
    The types are specified by putting <T,E> in our function's definition, after the 
    function's name. Think of T and E as placeholders for whichever type we use our function with.
    */
    static func sameType<T,E>(var1: T, inout var2: E) -> Void {
        print("not same type")
    }
    
    static func sameType<T>(var1: T, inout var2: T) -> Void {
        var2 = var1
    }
    
    /*
        inout
    */
    static func setParamTo10InOut(inout x: Int) {
        x = 10
    }

    static func setParamTo10NotInOut(var x: Int) {
        x = 10
    }
    
    /*
        Keyword : Equatable

        If you try to compile the bellow example (WITHOUT Equatable), the compiler will throw error in
    'if(item == array[index])'. 
    
    The compiler tells us that the binary operator == cannot be applied to two T operands. The reason is obvious if you think about it. We cannot guarantee that the generic type T supports the == operator. Luckily, Swift has this covered using Equatable
    
    Equatable is not the only protocol we can use. Swift has other protocols, such as Hashable and Comparable. We saw Comparable earlier in the binary tree example. If a type conforms to the Comparable protocol, it means the < and > operators are supported. I hope it's clear that you can use any protocol you like and apply it as a constraint.
    
    */
    
    static func find2 <T:Equatable> (array: [T], item : T) ->Int? {
        var index = 0
        while(index < array.count) {
            if(item == array[index]) {
                return index
            }
            index++
        }
        return nil;
    }
    
    static func check<T:Healthy>(inout object: T) {
        if (object.health <= 0) {
            object.setAlive(false)
        }
    }
    
    static func start () -> Void
    {
        /*
            Keyword : inout
            http://www.dotnetperls.com/inout-swift
        
            Most parameters are copied as values. They never affect the original call site. But inout parameters are different—they share a memory location.
        
            With inout, changes in the called method are reflected in the variables at the call site. The variables are not separate. This enables some code techniques.
        */
        
       
        var x = 0               // Value equals 0.
        print(x)                // prints 0
        setParamTo10NotInOut(x)
        print(x)                // prints 0
        setParamTo10InOut(&x)
        print(x)                // prints 10
        
        /*
            Lesson start
         */
        
        // Example 1
        var someString = "apple"
        var someInt    = 1
        
        sameType(2,          var2: &someInt)
        sameType(someString, var2: &someInt)
        
        // Example 2
        let array = ["a", "b", "c"]
        print(find2(array, item:"x"))  // prints nil
        print(find2(array, item:"b"))  // prints Optional(1)
    }
}




