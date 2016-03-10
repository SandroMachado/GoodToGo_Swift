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
            return "5ego6zf44mk1isi" /// TODO: ofuscate
        }
        static var DropboxAppSecret: String {
            return "adbgescpyvr1knv" /// TODO: ofuscate
        }
        static var DropboxAcessTokenSecret: String {
            return "meQImamoaCQAAAAAAAEg-h9djSRFTUUAFVu6ZkYFKJt-WghJH_luOuiq4Vapz8PY" /// TODO: ofuscate
        }
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


