//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

struct LMapReduceFilterSort
{
    
    struct Person {
        let name: String
        let age: Int
    }
    
    static func start () -> Void
    {
    
        for i in 0.stride(to: -8, by: -2) { print(i) } // 0 -2 -4 -6
        for i in 0.stride(through: -8, by: -2) { print(i) } // 0 -2 -4 -6 -8
        
        let people = [
            Person(name: "Katie",  age: 13),
            Person(name: "Bob",    age: 21),
            Person(name: "Rachel", age: 33),
            Person(name: "John",   age: 27),
            Person(name: "Megan",  age: 15)
        ]
        
        /**
        * Exercise 1 (map, reduce, filter)
        */
        if(false)
        {
            print("Exercise 1 (map, reduce)")
            let ages: [Int] = people.map { return $0.age }
            let agesSum     = ages.reduce(0) { return $0 + $1 }
            
            people.map({ p in print(p.name) })
            
            print ("ages: \(ages)")
            print ("agesSum: \(agesSum)")
            print (people.filter { $0.name == "Bob" }.first)
            
        }
        
        
        /**
        * Exercise 2 (reduce)
        */
        if(false)
        {
            print("Exercicio 2 (reduce)")
            let numbers = [Int](0..<10)
            let startValue = 0
            let sum2 = numbers.reduce(startValue) { return $0 + $1 }
            print ("sum2: \(sum2)")
        }
        
        
        /**
        * Exercise 3 (reduce)
        * Equivalente ao foldLeft: comecas com um valor, e nao final tens um resultado
        */
        if(false)
        {
            print("Exercicio 3 (reduce)")
            let booleans = [false, false, true, false, true, true]
            
            let allTrue = booleans.reduce(true) {
                (result, nextElement) in
                return result && nextElement
            }
            
            let allFalse = booleans.reduce(true) {
                (result, nextElement) in
                return result && !nextElement
            }
            
            let anyTrue = booleans.reduce(false) {
                (result, next) in
                return result || next
            }
            
            let anyFalse = booleans.reduce(false) {
                (result, nextElement) in
                return result || !nextElement
            }
            
            print(allTrue)
            print(allFalse)
            print(anyTrue)
            print(anyFalse)
        }
        
        
        /**
        * Exercise 4 (filter)
        */
        
        if(false)
        {
            print("Exercise 4 (filter)")
            var myList = [1, 2, 3, 4]
            print(myList.filter { $0 < 3 })
            print(myList.filter { $0 > 3 })
            
            print(people.filter { $0.age > 25 })
            
            // Verificar se existe um Ricardo
            let toFind = "Katie"
            
            let exists1 = people.filter { $0.name == toFind }.count>0;
            let exists2 = people.reduce(false) { (result, nextElement) in return result || (nextElement.name==toFind)};
            let exists3 = people.indexOf({$0.name == toFind})
            print(exists1)
            print(exists2)
            print(exists3)
        }
        
        /**
        * Exercise 5 (map)
        */
        
        if(false)
        {
            let someInts = [1, 2, 3]
            let squared = someInts.map{ someInt in someInt *  someInt }
            print(squared)
        }
        
        /**
        * Exercise 6 (sort)
        */
        
        if(false)
        {
            print(people.sort { $0.name.uppercaseString < $1.name.uppercaseString })
        }
        
        /**
         * Exercise 7 (guard)
         */
        
        func fooGuard(x: Int?) {
            guard let x = x where x > 0 else {
                // Value requirements not met, do something
                return
            }
            
            // Do stuff with x
            x.description
        }
        
        /**
        *  Exercise 8 (map, filter)
        */
        if(false)
        {
            print((1..<10).map{$0*$0}.filter {$0%2==0})
        }
        
        
        if(false)
        {
            enum AssetSize {
                case Size120(modifier: AssetModifier)
                case Size170(modifier: RestrictedModifier)
                case Size260(modifier: AssetModifier)
                case Size540(modifier: RestrictedModifier)
            }
            
            enum AssetModifier {
                case Circle
                case Full
            }
            enum RestrictedModifier {
                case Full
            }
            
            var x : AssetSize
            x = AssetSize.Size120(modifier: .Circle)
            x = AssetSize.Size120(modifier: .Full)
            x = AssetSize.Size170(modifier: .Full)
        }
    }
}