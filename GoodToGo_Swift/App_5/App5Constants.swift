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

enum App5Constants {
    enum Segues {
        static var Screen2: String {
            return "app5.modal.screen2"
        }
        static var Screen3: String {
            return "app5.modal.screen3"
        }
    }
    enum Notifications {
        static var TablePostsUpdated: String {
            return "TablePostsUpdated"
        }
        static var TableUsersUpdated: String {
            return "TableUsersUpdated"
        }
        static var TableCommentsUpdated: String {
            return "TableCommentsUpdated"
        }
        static var ShowNoInternetConnection: String {
            return "ShowNoInternetConnection"
        }
    }
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