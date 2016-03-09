//
//  GoodToGo_Swift
//
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

struct TableItem {
    let title: String
    let description: String
    let thumbnail: String
    let id: String
}

enum App7Constants {
    enum Segues {
        static var Screen2: String {
            return "app5.modal.screen2"
        }
        static var Screen3: String {
            return "app5.modal.screen3"
        }
    }
    enum Notifications {
        static var TableComicUpdated: String {
            return "TableComicUpdated"
        }
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
    enum MarvelApi {
        static var PublicKey: String {
            return "b909907f183968b09dd99a9cc5b27d72"
        }
        static var PrivateKey: String {
            return "87b64bb736e681a3e3b06b7baeaff0304e0f76f2"
        }
        static var CommicsEndPoint: String {
            return "http://gateway.marvel.com/v1/public/comics"
        }
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