//
//  GoodToGo_Swift
//
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

struct TableItem {
    let title: String
    let description: String
    let id: String
}

enum App6Constants {
    enum URL {
        static var Commments: String {
            return "http://jsonplaceholder.typicode.com/comments"
        }
        static var Users: String {
            return "http://jsonplaceholder.typicode.com/users"
        }
        static var Posts: String {
            return "http://jsonplaceholder.typicode.com/posts"
        }
    }
    enum Misc {
        static var DefaultAvatarImage: String {
            return "templateImage256x256.png"
        }
    }
}