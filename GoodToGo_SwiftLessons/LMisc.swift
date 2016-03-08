//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

struct LMisc
{
    static func start () -> Void
    {
        // MARK: (As with #pragma, marks followed by a single dash (-) will be preceded with a horizontal divider)
        
        /// Option 1: Your documentation comment will go here
        
        /**
        * Option 2: Your documentation comment will go here
        */
        
        /*!
        * Option 3: Your documentation comment will go here
        */
        
        
        if #available(iOS 9.0, *)
        {
            print("iOS 9.0!")
        }
        else
        {
            // Fallback on earlier versions
        };
        
        struct MyStruct {
            static func something() {
                print("Something")
            }
        }
        // MyStruct.something()
        
        class MyClass {
            class func someMethod() {
                print("Some Method")
            }
        }
        // MyClass.someMethod()
        
        /*
        * Comparar tipos
        */
        
        let obj = [AnyObject]()
        if let stringArray = obj as? [String] {
            // obj is a string array. Do something with stringArray
        }
        else
        {
            // obj is not a string array
        }
        
        /*
        * completion handler
        */
        // Defenicao 1
        func hardProcessingWithString(input: String, completion: (result: String) -> Void) {
            completion(result: "passed param: " + input)
        }
        
        // Caso de uso 1
        hardProcessingWithString("123", completion: { (result) -> Void in
            print("Done")
        });
        

        /*
         * Double switch
         */
        let os = NSProcessInfo().operatingSystemVersion
        switch (os.majorVersion, os.minorVersion, os.patchVersion) {
        case (8, 0, _):
            print("iOS >= 8.0.0, < 8.1.0")
        case (8, _, _):
            print("iOS >= 8.1.0, < 9.0")
        case (9, _, _):
            print("iOS >= 9.0.0")
        default:
            // this code will have already crashed on iOS 7, so >= iOS 10.0
            print("iOS >= 10.0.0")
        }
        
    }
}




