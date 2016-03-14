//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

/// TODO : Change names

// Constants that are shared (existing) in the the app's
enum AppGenericConstants {
    enum DefaultsKey {
        static var kNumberOfLogins: String {
            return "kNumberOfLogins"
        }
    }
    enum TableView {
        static var cellIdentifier: String {
            return "cellIdentifier"
        }
    }
    enum Notifications {
        static var ShowNoInternetConnection: String {
            return "ShowNoInternetConnection"
        }
    }
    enum APIs {
        static var DropboxAppKey: String {
            let result : [UInt8] = [53, 101, 103, 111, 54, 122, 102, 52, 52, 109, 107, 49, 105, 115, 105]
            return String.getPlainString(result)
        }
        static var DropboxAppSecret: String {
            let result : [UInt8] = [97, 100, 98, 103, 101, 115, 99, 112, 121, 118, 114, 49, 107, 110, 118]
            return String.getPlainString(result)
        }
        //static var DropboxAcessTokenSecret: String {
        //    let result : [UInt8] = [109, 101, 81, 73, 109, 97, 109, 111, 97, 67, 81, 65, 65, 65, 65, 65, 65, 65, 69, 103, 45, 104, 57, 100, 106, 83, 82, 70, 84, 85, 85, 65, 70, 86, 117, 54, 90, 107, 89, 70, 75, 74, 116, 45, 87, 103, 104, 74, 72, 95, 108, 117, 79, 117, 105, 113, 52, 86, 97, 112, 122, 56, 80, 89]
        //    return String.getPlainString(result)
        //}
    }
    enum ImagesBlundle {
        static var Loading1: String {
            return "loading1.png"
        }
        static var Downloading1: String {
            return "loading1.png"
        }
    }
    
}


