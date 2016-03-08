//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

var linksUIWebViewRequestHistory : Array = [String]()

class LinksUIWebView  : UIWebView {

    static func lastLoadedURL() -> String
    {
        return linksUIWebViewRequestHistory.last!;
    }
    
    static func cachedRequests() -> Int
    {
        return linksUIWebViewRequestHistory.count;
    }
    
    static func deleteRequest(url:String) -> Void
    {
        linksUIWebViewRequestHistory = linksUIWebViewRequestHistory.filter() { $0 != url }
    }
    
    static func deleteLastLoadedRequest() -> Void
    {
        deleteRequest(lastLoadedURL())
    }
    
    static func addURLToLoadRequests(url:String) -> Void
    {
        if(!HaveValue(url))
        {
            DLogWarning("Invalid URL [\(url)]");
            return;
        }
        if(linksUIWebViewRequestHistory.last != url)
        {
            if(!linksUIWebViewRequestHistory.contains(url))
            {
                linksUIWebViewRequestHistory.append(url);
            }
        }
    }
    
    func loadRequestString(urlString:String, cacheURL:Bool) -> String
    {
        guard HaveValue(urlString) else {
            DLogWarning("Invalid URL [\(urlString)]");
            return urlString
        }
        
        var auxURL = ToString(urlString)
        
        guard !String.isNullOrEmpty(auxURL) else {
            DLogWarning("Invalid URL [\(urlString)]");
            return urlString
        }
        
        if(!auxURL .hasPrefix("http://") && !auxURL .hasPrefix("https://"))
        {
            if(!auxURL .hasPrefix("www"))
            {
                auxURL = "http://www." + auxURL
            }
            else
            {
                auxURL = "https://" + auxURL
            }
        }
        let url = NSURL (string: auxURL)
        if(HaveValue(url))
        {
            if(cacheURL)
            {
                LinksUIWebView.addURLToLoadRequests(auxURL)
            }
            DLog("Loading request : " + auxURL)
            let requestObj = NSURLRequest(URL: url!);
            self.loadRequest(requestObj)
        }
        else
        {
            DLogError("URL inválido " + "[\(auxURL)]");
        }
        return auxURL;
    }
}