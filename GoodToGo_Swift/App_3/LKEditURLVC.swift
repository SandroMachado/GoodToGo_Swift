//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 22/01/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

import UIKit

class LKEditURLVC: UIViewController, UIWebViewDelegate
{
    private var validURL  : Bool = false;

    @IBOutlet weak var lblURL_: UILabel?;
    @IBOutlet weak var lblName_: UILabel?;
    @IBOutlet weak var btnSave_: UIButton?;
    @IBOutlet weak var btnDelete_: UIButton?;
    @IBOutlet weak var wvPreview_: LinksUIWebView?;
    @IBOutlet weak var txtURL_: UITextField?;
    @IBOutlet weak var txtName_: UITextField?;
    @IBOutlet weak var toolbar_: UIToolbar?;


    @IBOutlet var backGroundLabel1_: UILabel?;
    @IBOutlet var backGroundLabel2_: UILabel?;

    var urlName  : String = ""
    var urlValue : String = ""

    // MARK: - IBActions
    @IBAction func btnSavePressed(sender: AnyObject)
    {
        self.urlName  = RJSOptionalUtils.safeUIElementGetText(self.txtName_)
        self.urlValue = RJSOptionalUtils.safeUIElementGetText(self.txtURL_)
        
        guard !String.isNullOrEmpty(self.urlName) else {
            RJSMessagesManager.showAlert(sender: self, title: "Error", message: "Please choose a name first");
            return;
        }
        
        guard !String.isNullOrEmpty(self.urlValue) else {
            RJSMessagesManager.showAlert(sender: self, title: "Error", message: "Please choose a url first");
            return;
        }
        
        if(!self.validURL)
        {
            RJSMessagesManager.showAlert(sender: self, title: "Error", message: "Inválid url");
            return;
        }

        // Antes de salvar, apagamos sempre o anterior
        App3BusinessLayer.deleteURL(self.urlName);
        App3BusinessLayer.addURL(self.urlName, urlValue: self.urlValue );
        
        RJSMessagesManager.showSmallTopMessage("Saved....");
    }
    
    @IBAction func btnDeletePressed(sender: AnyObject)
    {
        self.urlName     = RJSOptionalUtils.safeUIElementGetText(self.txtName_);
        let deleteSucess = App3BusinessLayer.deleteURL(self.urlName);
        if(deleteSucess)
        {
            RJSMessagesManager.showSmallTopMessage("Delete!")
            self.dismissViewController(self)
        }
    }
    
    // MARK: - UITextField Delegate
    func textField(textField: UITextField!, shouldChangeCharactersInRange
        range: NSRange,
        replacementString string: String!) -> Bool {

        //your code
        if(textField==txtName_)
        {

        }
        else if(textField==txtURL_)
        {
            let isBackSpace = string == "";
            var urlToTest = RJSOptionalUtils.safeUIElementGetText(txtURL_!.text) + string;
            if(isBackSpace && urlToTest.countUTF8()>0)
            {
                urlToTest = urlToTest.substringToIndex(urlToTest.endIndex.predecessor())
            }
            self.wvPreview_?.loadRequestString(urlToTest, cacheURL: false);
        }
        
        return true
    }
    
    // MARK: - Auxiliar
    func prepareLayout()
    {
       
        RJSLayoutsManager.App_Links.LayoutBackround_1(self.view);
        
        wvPreview_!.delegate = self;
        wvPreview_!.scrollView.bounces = false;
        wvPreview_!.setCornerRadius(3);
        
        /*
         * Layout das labels de fundo
         */
        RJSLayoutsManager.App_Links.LayoutBackgroundLabelOrView(self.backGroundLabel1_);
        RJSLayoutsManager.App_Links.LayoutBackgroundLabelOrView(backGroundLabel2_);
        
        RJSLayoutsManager.App_Links.LayoutLabel_Title_1(lblName_);
        RJSLayoutsManager.App_Links.LayoutLabel_Title_1(lblURL_);
        RJSLayoutsManager.App_Links.LayoutTextField_1(txtURL_);
        RJSLayoutsManager.App_Links.LayoutTextField_1(txtName_);

        /*
         * Layout dos botoes
         */
        RJSLayoutsManager.App_Links.LayoutUIButtonSucess_1(btnSave_);
        RJSLayoutsManager.App_Links.LayoutUIButtonDelete_1(btnDelete_);
        
        if(!String.isNullOrEmpty(self.urlName))
        {
            self.txtName_?.text = String.cleanString(self.urlName);
        }
        if(!String.isNullOrEmpty(self.urlValue))
        {
            self.txtURL_?.text = String.cleanString(self.urlValue);
            self.urlValue      = (self.wvPreview_?.loadRequestString(self.urlValue, cacheURL: false))!;
        }
        
        var titleMessage = "";
        if(App3BusinessLayer.urlIsStored(self.urlName) || App3BusinessLayer.urlIsStored(self.urlValue))
        {
            titleMessage = "Edit URL"
            btnDelete_?.hidden = false;
        }
        else
        {
            titleMessage = "Add URL"
            btnDelete_?.hidden = true;
        }
        
        // Prepare Toolbar
        let flexBarButton1 = RJSProgramaticControls.GetUIBarButtonFlexibleSpace()
        let flexBarButton2 = RJSProgramaticControls.GetUIBarButtonFlexibleSpace()
        let btnBack        = RJSProgramaticControls.GetUIBarButtonItemBack(self)
        let lblTitle       = RJSProgramaticControls.GetUILabel(titleMessage)
        RJSLayoutsManager.App_Links.LayoutBackgroundTitleLabel(lblTitle)
        let btnTitle = UIBarButtonItem(customView: lblTitle);
        toolbar_!.items = [flexBarButton1, btnTitle,flexBarButton2, btnBack];

        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?)
    {
        validURL = false;
        RJSErrorsManager.handleError(error)
        RJSUtils.setActivityIndicatorToState(false)
        webView.fadeOutTo(0.2, duration: 0, delay: 0)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView)
    {
        webView.fadeInTo(1, duration: 0, delay: 0)
        validURL = true;
        RJSUtils.setActivityIndicatorToState(true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        RJSUtils.setActivityIndicatorToState(false)
    }
    
    // MARK: - Page Life Cicle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        
        prepareLayout();
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
    }
    
}