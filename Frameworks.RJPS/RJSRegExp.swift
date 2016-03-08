//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

struct RJSRegExp
{
    static func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matchesInString(text,
                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        let string = "{city = Gwenborough; geo = {lat = \"-37.3159\";lng = \"81.1496\";};street = \"Kulas Light\";suite = \"Apt. 556\";zipcode = \"92998-3874\";}"
        
        let matches = matchesForRegexInText("-?[0-9]{2}[.][0-9]{4}", text: string)
        
        assert(matches[0]=="-37.3159")
        assert(matches[1]=="81.1496")
    }
    
}


