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
    enum Keys {
        static var DropboxUserAcessToken: String {
            return "dropbox_api_userAcessToken"
        }
    }
    enum Segues {
        static var Screen2: String {
            return "app7.modal.screen2"
        }
        static var Screen3: String {
            return "app7.modal.screen3"
        }
    }
    enum Notifications {
        static var TableComicUpdated: String {
            return "TableComicUpdated"
        }
        static var ShowNoInternetConnection: String {
            return "ShowNoInternetConnection"
        }
    }
    enum MarvelApi {
        static var PublicKey: String {
            let result : [UInt8] = [98, 57, 48, 57, 57, 48, 55, 102, 49, 56, 51, 57, 54, 56, 98, 48, 57, 100, 100, 57, 57, 97, 57, 99, 99, 53, 98, 50, 55, 100, 55, 50]
            return String.getPlainString(result)
        }
        static var PrivateKey: String {
            let result : [UInt8] = [56, 55, 98, 54, 52, 98, 98, 55, 51, 54, 101, 54, 56, 49, 97, 51, 101, 51, 98, 48, 54, 98, 55, 98, 97, 101, 97, 102, 102, 48, 51, 48, 52, 101, 48, 102, 55, 54, 102, 50]
            return String.getPlainString(result)
        }
        static var ComicsEndPoint: String {
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
        static var MaxNumberOfComicsInSingleRequest : Int {
            return 100
        }
    }
    enum Images {
        static var DefaultCoverImage: String {
            return "templateImage256x256.png"
        }
    }
    
    
}