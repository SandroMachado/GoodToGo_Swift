//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation

class App3BusinessLayer {
    
    static func defaultURL()->String
    {
        return "https://google.com"
    }
    
    static func urlIsStored(var url:String)->Bool
    {
        if(String.isNullOrEmpty(url))
        {
            return false;
        }
        let storeds = storedURLs()
        url = String.cleanString(url);
        for kv in storeds
        {
            let key   = kv.0;
            let value = kv.1;
            if(url==value || url==key)
            {
                return true;
            }
        }
        return false;
    }
    
    static func deleteURL(urlKey:String)->Bool
    {

        let stores = storedURLs()

        let before = stores.count;
        
        // Apagar tudo.
        RJSStorages.saveToDefaults(nil, key:App3Constants.DefaultsKey.kUserURLS)
        
        // Salvar tudo menos o que apagamos
        var result = false;
        for kv in stores
        {
            let key   = kv.0;
            let value = kv.1;
            if(!(urlKey==key))
            {
                addURL(key, urlValue:value)
            }
            else
            {
                result = true;
            }
        }
        let after = storedURLs().count;
        if(!(after==before-1))
        {
            result = false;
            DLogError("Erro a apagar url [\(urlKey)]");
        }
        return result;
    }
    
    static func addURL(var urlName:String ,urlValue:String)->Void
    {
        var storedURLS = RJSStorages.readFromDefaults(App3Constants.DefaultsKey.kUserURLS);
        if(!HaveValue(storedURLS))
        {
            storedURLS = [String:String]()
        }
        
        guard !String.isNullOrEmpty(urlValue) else {
            DLogError("URL vazio");
            return
        }
        
        if(String.isNullOrEmpty(urlName))
        {
            urlName = urlValue;
        }
        else
        {
            urlName = String.cleanString(urlName);
        }
        if var casted = storedURLS as? [String:String]
        {
            casted[urlName] = urlValue;
            RJSStorages.saveToDefaults(casted, key:App3Constants.DefaultsKey.kUserURLS)
        }
    }
    
    static func storedURLs()->[String:String]
    {
        var storedURLS = RJSStorages.readFromDefaults(App3Constants.DefaultsKey.kUserURLS);
        if(!HaveValue(storedURLS))
        {
            addURL("Google",    urlValue:"https://www.google.com");
            addURL("Facebook",  urlValue:"https://www.facebook.com");
            addURL("LinkedIn",  urlValue:"https://www.linkedin.com");
            addURL("Whatsapp",  urlValue:"https://web.whatsapp.com");
            addURL("Instagram", urlValue:"https://www.instagram.com");
            addURL("Dropbox",   urlValue:"https://www.dropbox.com");
            addURL("Trello",    urlValue:"https://trello.com/");
            addURL("GMail",     urlValue:"https://gmail.com/");
            addURL("Amazon",    urlValue:"https://amazon.com/");
            addURL("Wikipedia", urlValue:"https://wikipedia/");
            addURL("Pinterest", urlValue:"https://pinterest.com/");
            addURL("Baidu",     urlValue:"https://www.baidu.com/");

            storedURLS = storedURLs();
        }
        return storedURLS as! [String:String];
    }
    
}