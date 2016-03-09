//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

struct RJSFilesManager
{
    enum Folder: Int {
        case Documents = 1, Temp
    }
    
    static func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    static func getTempDirectory() -> NSString {
        return NSTemporaryDirectory()
    }
    
    static func getImage(name:String, folder:Folder=RJSFilesManager.Folder.Documents) -> UIImage? {
        guard !name.isEmpty else {
            DLogWarning("Invalide name")
            return nil;
        }
        
        var path = ""
        switch (folder) {
        case Folder.Documents:
            path = getDocumentsDirectory() as String
            break;
        case Folder.Temp:
            path = getTempDirectory() as String
            break;
        }
        
        let filename = "\(path)/\(name)"
        let result   = UIImage(contentsOfFile: filename)
        if(!HaveValue(result)) {
            DLogWarning("Error getting image \(name) from file system")
        }
        return result;
    }
    
    static func saveImage(name:String, folder:Folder, image:UIImage) -> Bool {
        guard !name.isEmpty else {
            DLogWarning("Invalide name")
            return false;
        }
        
        var path = ""
        switch (folder) {
        case Folder.Documents:
            path = getDocumentsDirectory() as String
            break;
        case Folder.Temp:
            path = getTempDirectory() as String
            break;
        }
        
        if let data = UIImagePNGRepresentation(image) {
            let filename = "\(path)/\(name)"
            data.writeToFile(filename, atomically: true)
            return true
        }
        DLogError("Error saving image \(name)")
        return false
    }
    
    static func clearFolder(folder:Folder) {
        var docsFolder : String = ""
        switch (folder) {
        case Folder.Documents:
            docsFolder = getDocumentsDirectory() as String
            break;
        case Folder.Temp:
            docsFolder = getTempDirectory() as String
            break;
        }
        
        let fileManager = NSFileManager.defaultManager()
        
        do {
            let filePaths = try fileManager.contentsOfDirectoryAtPath(docsFolder as String)
            for filePath in filePaths {
                deleteFile(docsFolder + "/" + filePath)
            }
        } catch {
            DLogError("Could not clear folder: \(error)")
        }
    }
    
    static func deleteFile(fileFullPath:String) ->Bool {
        let fileManager = NSFileManager.defaultManager()
        do {
            try fileManager.removeItemAtPath(fileFullPath)
            return true
        } catch {
            DLogError("Could not clear folder: \(error)")
        }
        return false
    }
    
}
