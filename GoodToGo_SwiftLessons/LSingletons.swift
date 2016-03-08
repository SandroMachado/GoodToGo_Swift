//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

struct LSingletons
{
    /**
     * Singleton
     */
    class ViewModel {
        static let sharedInstance: ViewModel =
        {
            let instance = ViewModel()
            return instance
        }()
    }
    
    static func start () -> Void
    {
    }
}




