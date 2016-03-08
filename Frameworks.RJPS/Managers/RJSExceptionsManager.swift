//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

struct RJSExceptionsManager
{
    // TODO: Finish
    static func handleException(ex : AnyObject) -> Bool
    {
        if(HaveValue(ex))
        {
            DLogError(ex);
            return true;
        }
        else
        {
            return false;
        }
    }
}
