//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 27/12/15.
//  Copyright © 2015 Ricardo Santos. All rights reserved.
//

import UIKit

class LKMainScreenVC: UINavigationController, RJSChoivesVCDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, UIWebViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate
{

    private var toolBar_: UIToolbar?
    private var webView_: LinksUIWebView?

    private var btnBackWasPressed = false
    private var lastURL: String = ""
    private var lastKey: String = ""
    
    // MARK: - UIScrollView
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: - UIScrollView
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {

    }
    
    func restoreScreen() -> Void
    {
        let toolbarHeight  = RJSSizes.UIToolbar.height+RJSSizes.CarrierStatusBar.height
        toolbarHided       = false
        let pointOffScreen = CGPointMake(RJSSizes.Screen.width/2.0, (RJSSizes.UIToolbar.height/2.0)+RJSSizes.CarrierStatusBar.height)
        toolBar_?.moveTo(point: pointOffScreen, spring: false, duration: 0, delay: 0)
        UIView.animateWithDuration(0.3, animations: {
            self.webView_!.frame = CGRectMake(0, toolbarHeight, RJSSizes.Screen.width, RJSSizes.Screen.height-toolbarHeight)
        })
    }
    
    var toolbarHided = false;
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let contentOffset  = scrollView.contentOffset.y

        if(!toolbarHided && contentOffset>1)
        {
            /*
             * Hide UIToolbar and scretch UIWebview
             */
            let toolbarHeight  = RJSSizes.UIToolbar.height+RJSSizes.CarrierStatusBar.height
            toolbarHided       = true
            let pointOffScreen = CGPointMake(RJSSizes.Screen.width/2.0, -toolbarHeight/2.0)
            toolBar_?.moveTo(point: pointOffScreen, spring: false, duration: 0, delay: 0)
            UIView.animateWithDuration(0.3, animations: {
                self.webView_!.frame = CGRectMake(0, 0, RJSSizes.Screen.width, RJSSizes.Screen.height)
            })
        }
        
        if(toolbarHided && contentOffset==0)
        {
            /*
             * Hide UIToolbar and scretch UIWebview
             */
            restoreScreen()
        }
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView)
    {
     //   print("scrollViewWillBeginDecelerating")
    }
    
    // MARK: - IBActions
    @IBAction func btnEditPressed(sender: AnyObject?)
    {
        if(!App3BusinessLayer.urlIsStored(String(self.lastKey)) && !App3BusinessLayer.urlIsStored(String(self.lastURL)))
        {
            self.btnNewPressed(nil);
        }
        else
        {
            let controller = LKEditURLVC();
            controller.urlName  = String(self.lastKey);
            controller.urlValue = String(self.lastURL);
            controller.presentFrom(self, addDismissToolbar:true);
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func btnBackPressed(sender: AnyObject?)
    {
        // Apagar da cache o ulr actual
        let currentURL       = webView_!.request?.URL;
        let currentURLString = String.cleanString("\(currentURL)");
        LinksUIWebView.deleteRequest(currentURLString);
        
        let last = LinksUIWebView.lastLoadedURL();
        if(HaveValue(last))
        {
            btnBackWasPressed = true;
            
            RJSMessagesManager.showSmallTopMessage("\(last)");
            webView_!.loadRequestString(last, cacheURL: false);
        }
    }
    
    @IBAction func btnActionPressed(sender: AnyObject?)
    {
        let choices = RJSChoivesVC();
        choices.dataSourceDic = App3BusinessLayer.storedURLs();
        choices.delegate      = self;
        choices.presentFrom(self, addDismissToolbar:true);
    }
    
    @IBAction func btnNewPressed(sender: AnyObject?)
    {
        let lastLoadedURL = LinksUIWebView.lastLoadedURL();
        if(!App3BusinessLayer.urlIsStored(lastLoadedURL) && !String.isNullOrEmpty(lastLoadedURL))
        {
            // O URL actual não está na lista. Salvar como novo
            let controller      = LKEditURLVC();
            controller.urlValue = lastLoadedURL;
            controller.presentFrom(self, addDismissToolbar:true);
        }
        else
        {
            // URL completamente novo
            let controller      = LKEditURLVC();
            controller.urlValue = "https://google.com";
            controller.urlName  = "Google";
            controller.presentFrom(self, addDismissToolbar:true);
        }
    }
    
    // MARK: - Auxiliar
    func prepareLayout()
    {
        
        self.hideNavigationBarHidden();
        
        webView_?.scrollView.bounces = false

        if(toolBar_==nil && webView_==nil)
        {
            toolBar_ = UIToolbar(frame: CGRectMake(0, RJSSizes.CarrierStatusBar.height, UIScreen.mainScreen().bounds.width, RJSSizes.UIToolbar.height))
            webView_ = LinksUIWebView(frame: CGRectMake(0, RJSSizes.UIToolbar.height+RJSSizes.CarrierStatusBar.height, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-RJSSizes.UIToolbar.height-RJSSizes.CarrierStatusBar.height))
            webView_!.delegate = self
            
            lastURL = String(RJSStorages.readFromDefaults(App3Constants.DefaultsKey.kLastLoadedURL))
            lastKey = String(RJSStorages.readFromDefaults(App3Constants.DefaultsKey.kLastLoadedKey))
            
            lastURL = String.cleanString(lastURL)
            lastKey = String.cleanString(lastKey)
            
            toolBar_!.sizeToFit()
            toolBar_?.tintColor = UIColor.purpleColor()
            self.view.addSubview(webView_!)
            self.view.addSubview(toolBar_!)

        }
        
        let flexBarButton = RJSProgramaticControls.GetUIBarButtonFlexibleSpace()
        
        let btnEdit = RJSProgramaticControls.GetUIBarButtonItem(nil, image:"pencil-8x.png",backgroundColor:nil,target:self,action:Selector("btnEditPressed:"))
        
        let btnLinks = RJSProgramaticControls.GetUIBarButtonItem(nil, image:"list-8x.png",backgroundColor:nil,target:self,action:Selector("btnActionPressed:"))
        
        let btnNew = RJSProgramaticControls.GetUIBarButtonItem(nil, image:"plus-6x.png",backgroundColor:nil,target:self,action:Selector("btnNewPressed:"))
        
        let btnBack = RJSProgramaticControls.GetUIBarButtonItem(nil, image:"action-undo-8x.png",backgroundColor:nil,target:self,action:Selector("btnBackPressed:"))

        var items = [UIBarButtonItem]()
        
        let cachedRequests = LinksUIWebView.cachedRequests()
        if(cachedRequests>1)
        {
            items.append(btnBack)
        }
        items.append(flexBarButton)
        items.append(btnNew)
        items.append(btnEdit)
        items.append(btnLinks)
            
        toolBar_!.items = items;
            
    }
    
    // MARK: - RJSChoivesVCDelegate
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?)
    {
        RJSUtils.setActivityIndicatorToState(false)
        RJSErrorsManager.handleError(error)
        RJSMessagesManager.showAlert(sender: self, title: "Error", message: "\(error)")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView)
    {
        RJSUtils.setActivityIndicatorToState(true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        let url       = webView.request?.URL;
        let urlString = String.cleanString("\(url)");
        if(!String.isNullOrEmpty(urlString) && !btnBackWasPressed)
        {
            // Apenas cachamos o URL se o botao de back não tiver sido carregado
            LinksUIWebView.addURLToLoadRequests(urlString)
        }
        btnBackWasPressed = false;
        RJSUtils.setActivityIndicatorToState(false)
        prepareLayout()
    }
    
    // MARK: - RJSChoivesVCDelegate
    func rjsChoivesLayoutTableView(rjsChoive: RJSChoivesVC, tableView:UITableView)
    {
        RJSLayoutsManager.App_Links.LayoutRJSChoices(rjsChoive, tableView:tableView);
    }
    
    func rjsChoivesLayoutCell(rjsChoive: RJSChoivesVC, cell:UITableViewCell, object:AnyObject)
    {
        RJSLayoutsManager.App_Links.LayoutUITableViewCell_1(cell);
    }
    
    func rjsChoivesDidSelectRowAtIndexPath(choices:RJSChoivesVC, indexPath:NSIndexPath)
    {
        let urls     = RJSStorages.readFromDefaults(App3Constants.DefaultsKey.kUserURLS);
        self.lastKey = choices.currentSeletecObject as! String;
        self.lastURL = String(urls?.valueForKey(self.lastKey));
        
        RJSStorages.saveToDefaults(self.lastURL, key: App3Constants.DefaultsKey.kLastLoadedURL);
        RJSStorages.saveToDefaults(self.lastKey, key: App3Constants.DefaultsKey.kLastLoadedKey);
        
        if(false)
        {
            choices.dismissViewController(self);
        }
        else
        {
            let alertController = UIAlertController(title: "Options", message: "", preferredStyle: .ActionSheet)
            
            let actionSee = UIAlertAction(title: "Open", style: .Default) { (action) in
                choices.dismissViewControllerAnimated(false) { () -> Void in }
                RJSStorages.saveToDefaults(self.lastURL, key: App3Constants.DefaultsKey.kLastLoadedURL);
            }
            
            let actionEdit = UIAlertAction(title: "Edit", style: .Default) { (action) in
                let controller = LKEditURLVC();
                controller.urlName  = String(self.lastKey);
                controller.urlValue = self.lastURL;
                controller.presentFrom(choices, addDismissToolbar:true);
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .Default) { (action) in
            }
            
            alertController.addAction(actionSee)
            alertController.addAction(actionEdit)
            alertController.addAction(actionCancel)
            
            choices.presentViewController(alertController, animated: true) { }
        }
    }
    
    // MARK: - Page Life Cicle
    
    override func viewDidLoad()
    {
        self.tabBarController?.tabBar.hidden = true
        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        
        prepareLayout()
        webView_!.scrollView.delegate = self

    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        lastURL = String.cleanString(lastURL);
        lastKey = String.cleanString(lastKey);
        
        if(String.isNullOrEmpty(lastURL) || !App3BusinessLayer.urlIsStored(lastURL))
        {
            /// FIX: hardcoded
            lastURL = "https://www.google.com";
            lastKey = "Google"
            RJSMessagesManager.showSmallTopMessage("Loading default url...");
            webView_!.loadRequestString(lastURL, cacheURL: true);

        }
        else
        {
            if(!String.isNullOrEmpty(lastKey))
            {
                RJSMessagesManager.showSmallTopMessage("Loading \(lastKey)...");
            }
            webView_!.loadRequestString(lastURL, cacheURL: true);
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }

}
