//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

/*
 * Não associar a nenhuma class! Assim estão acessiveis a partir de qualquer ponto da aplicação. 
 * Usar apenas para funcoes muito importantes!
 */

//public typealias RJSPCompletionHandler = (AnyObject?, NSError?) -> Void


    func assertRJPS(@autoclosure predicate : () -> Bool) {
        #if !NDEBUG
        if !predicate() {
            abort()
        }
        #endif
    }

    func IsDebug() -> Bool
    {
        #if NDEBUG
            return false;
        #else
            return true;
        #endif
    }

    func DLog(message: AnyObject?, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__)
    {
        guard HaveValue(message) else {
            return
        }
        
        let messageToPrint = ToString(message)
        let fileName = file.splitByChar("/").last!
        print("\n📌 \(fileName) | \(function)\n📝 \(messageToPrint) ")
    }

    func DLogError(error: AnyObject?, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__)
    {
        guard HaveValue(error) else {
            return
        }
        
        let fileName = file.splitByChar("/").last!
        let messageToPrint = ToString(error)
        print("\n📌 \(fileName) | \(function)\n🚫 \(messageToPrint) ")
        if(false)
        {
            fatalError(messageToPrint)
        }
    }

    func DLogWarning(message: String?, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__)
    {
        guard HaveValue(message) else {
            return
        }
        let messageToPrint = ToString(message)
        let fileName = file.splitByChar("/").last!
        print("\n📌 \(fileName) | \(function)\n🔶 \(messageToPrint) ")
    }

    func GetLocation() -> String
    {
        return "\(__FUNCTION__) \(__FILE__)"
    }

    func isIOSVersion(version: Int) -> Bool
    {
        let os = NSProcessInfo().operatingSystemVersion
        return os.majorVersion==version
    }

    func ToString(someObject : AnyObject?, resultIfObjectIsNill : String="")->String
    {
        if(HaveValue(someObject))
        {
            return String.cleanString(someObject!.description);
        }
        if(HaveValue(resultIfObjectIsNill))
        {
            return resultIfObjectIsNill;
        }
        return ""
    }

    func HaveValue(someObject : AnyObject?) -> Bool
    {
        if (someObject != nil)
        {
            return true;
        }
        return false;
    }




