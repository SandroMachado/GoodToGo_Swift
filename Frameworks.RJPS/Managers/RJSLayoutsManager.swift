//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

//
// Generic RJSLayoutsManager Class!
// 
// This class shoud be extented in each App_x
//

/*
 * Sample extension :
    extension RJSLayoutsManager
    {
        class App_Links
        {
            static func LayoutBackround_1(view:UIView)
            {
                RJSLayoutsManager.LayoutBackgroundView(view, backgroudImage: nil, backgroundColor: nil)
            }

            static func LayoutLabel_Title_1(label:UILabel?)
            {
                RJSLayoutsManager.LayoutLabel(label, fontSize: 0, fontColor: nil)
            }
    }
 */

class RJSLayoutsManager
{
    enum RJSLayoutsManagerConstants
    {
        enum FontName {
            static var HelveticaNeue_Thin: String {
                return "HelveticaNeue-Thin"
            }
            static var MarkerFelt_Thin: String {
                return "MarkerFelt-Thin"
            }
        }
        
        enum Default {
            static var Font: String {
                return FontName.HelveticaNeue_Thin
            }
            static var FontSize: CGFloat {
                return 16.0
            }
            static var BackgroundColor: UIColor {
                return UIColor.colorFromRGBString("250,250,250")
            }
            static var LabelsBackgroundColor: UIColor {
                return UIColor.colorFromRGBString("239,239,244")
            }
            static var LabelsTextColor: UIColor {
                return UIColor.darkGrayColor()
            }
        }
    }
    

    /*
     * Customizacao
     */
    static func layoutBackgroundLabelOrView(lblOrView:UIView?, cornerSize:Int) -> Void
    {
        guard HaveValue(lblOrView) else {
            DLogWarning("Ignored...")
            return
        }
        lblOrView!.backgroundColor = RJSLayoutsManagerConstants.Default.LabelsBackgroundColor;
        lblOrView!.alpha = 0.8
        lblOrView?.setCornerRadius(cornerSize)
    }
    
    static func layoutBackgroundLabelsIn(containner:UIView, corner:Int) -> Void
    {
        let backViewsTag = 999;
        let backgrounds = containner.getSubViewsWithTag(backViewsTag)
        for view in backgrounds
        {
            self.layoutBackgroundLabelOrView(view, cornerSize:corner);
        }
    }
    
    static func LayoutBackgroundView(view:UIView, backgroudImage:UIImage?, backgroundColor:UIColor?)
    {
        view.backgroundColor = RJSLayoutsManagerConstants.Default.BackgroundColor
        if(HaveValue(backgroundColor))
        {
            view.backgroundColor = backgroundColor
        }
    }
    
    static func LayoutNavigationBar(textColor:UIColor?)
    {
        if(HaveValue(textColor)) {
            UINavigationBar.appearance().tintColor = UIColor.redColor()
        }
        else {
            UINavigationBar.appearance().tintColor = RJSLayoutsManagerConstants.Default.LabelsTextColor
        }
        
        // Cor dos botoes
        UIBarButtonItem.appearance().tintColor = RJSLayoutsManagerConstants.Default.LabelsTextColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: RJSLayoutsManagerConstants.FontName.HelveticaNeue_Thin, size: 10)!
        ]
        
        UINavigationBar.appearance().backgroundColor = UIColor.greenColor()
        UITabBar.appearance().backgroundColor        = UIColor.yellowColor();
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    /*
     * Customizacao
     */
    static func LayoutLabel(label:UILabel?, fontSize:CGFloat, fontColor:UIColor?)
    {
        guard HaveValue(label) else {
            DLogWarning("Ignored...")
            return
        }
        let font = UIFont(name: RJSLayoutsManagerConstants.FontName.HelveticaNeue_Thin, size: RJSLayoutsManagerConstants.Default.FontSize)!
        label!.font = font
        if(fontSize>0)
        {
            label!.setFontSize(fontSize)
        }
        if(HaveValue(fontColor))
        {
            label!.textColor = fontColor
        }
        else
        {
            label!.textColor = RJSLayoutsManagerConstants.Default.LabelsTextColor
        }
    }

    static func LayoutTextField(txtField:UITextField?, fontSize:CGFloat, fontColor:UIColor?)
    {
        guard HaveValue(txtField) else {
            DLogWarning("Ignored...")
            return
        }
        let font = UIFont(name: RJSLayoutsManagerConstants.FontName.HelveticaNeue_Thin, size: RJSLayoutsManagerConstants.Default.FontSize)!
        txtField!.font = font
        if(fontSize>0)
        {
            txtField!.font = txtField!.font!.fontWithSize(fontSize)
        }
        txtField!.backgroundColor = UIColor.clearColor();
        if(HaveValue(fontColor))
        {
            txtField!.textColor = fontColor;
        }
        else
        {
            txtField!.textColor = RJSLayoutsManagerConstants.Default.LabelsTextColor
        }
    }
    
    static func LayoutTextView(txtView:UITextView?, fontSize:CGFloat, fontColor:UIColor?)
    {
        guard HaveValue(txtView) else {
            DLogWarning("Ignored...")
            return
        }
        let font = UIFont(name: RJSLayoutsManagerConstants.FontName.HelveticaNeue_Thin, size: RJSLayoutsManagerConstants.Default.FontSize)!
        txtView!.font = font
        if(fontSize>0)
        {
            txtView!.font = txtView!.font!.fontWithSize(fontSize)
        }
        txtView!.backgroundColor = UIColor.clearColor();
        if(HaveValue(fontColor))
        {
            txtView!.textColor = fontColor;
        }
        else
        {
            txtView!.textColor = RJSLayoutsManagerConstants.Default.LabelsTextColor
        }
    }
    
    static func LayoutUIButton(button:UIButton?, fontSize:CGFloat, fontColor:UIColor?, backgroudImage:UIImage?, backgroundColor:UIColor?, borderSize:Int)
    {
        guard HaveValue(button) else {
            DLogWarning("Ignored...")
            return
        }
        let font = UIFont(name: RJSLayoutsManagerConstants.FontName.HelveticaNeue_Thin, size: RJSLayoutsManagerConstants.Default.FontSize)!
        button!.titleLabel!.font = font;
        if(fontSize>0)
        {
            button!.titleLabel!.font = button!.titleLabel!.font!.fontWithSize(fontSize)
        }
        
        if(HaveValue(fontColor))
        {
            button!.titleLabel!.textColor = fontColor;
        }
        else
        {
            button!.titleLabel!.textColor = RJSLayoutsManagerConstants.Default.LabelsTextColor
        }
        if(HaveValue(backgroundColor))
        {
            button!.backgroundColor = backgroundColor;
        }
        if(HaveValue(backgroudImage))
        {
            button!.setBackgroundImage(backgroudImage, forState: .Normal)
        }
        
        button!.setCornerRadius(borderSize)
    }
}



