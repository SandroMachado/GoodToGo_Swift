
import Foundation
import UIKit

class RJSConvert {
    
    static func stringToCGFloat(string:AnyObject?)-> CGFloat
    {
        if(!HaveValue(string)) {
            return 0.0
        }
        if let n = NSNumberFormatter().numberFromString(ToString(string))
        {
            return CGFloat(n)
        }
        DLogWarning("Fail on converting \(string)")
        return 0;
    }
    
    static func convertToDouble(string:AnyObject?)-> Double
    {
        if(!HaveValue(string)) {
            return 0.0
        }
        if let n = NSNumberFormatter().numberFromString(ToString(string))
        {
            return Double(n)
        }
        DLogWarning("Fail on converting \(string)")
        return 0;
    }
    
    static func convertToFloat(string:AnyObject?)-> Float
    {
        if(!HaveValue(string)) {
            return 0.0
        }
        if let n = NSNumberFormatter().numberFromString(ToString(string))
        {
            return Float(n)
        }
        DLogWarning("Fail on converting \(string)")
        return 0;
    }
    
    static func convertToInt(string:AnyObject?)-> Int
    {
        if(!HaveValue(string)) {
            return 0
        }
        if let n = NSNumberFormatter().numberFromString(ToString(string))
        {
            return Int(n)
        }
        DLogWarning("Fail on converting \(string)")
        return 0;
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        assert(stringToCGFloat("2")==2.0)
        assert(stringToCGFloat("2.0")==2.0)
        assert(stringToCGFloat(nil)==0.0)
        
        assert(convertToDouble("2")==2.0)
        assert(convertToDouble("2.0")==2.0)
        assert(convertToDouble(nil)==0.0)
        
        assert(convertToInt("2")==2)
        assert(convertToInt("2.0")==2)
        assert(convertToInt(nil)==0)
    }
}





