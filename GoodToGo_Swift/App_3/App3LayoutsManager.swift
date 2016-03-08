//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension RJSLayoutsManager
{
   /*
    * Specific RJSLayoutsManager Class!
    */
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
        
        static func LayoutLabel_Value_1(label:UILabel?)
        {
            RJSLayoutsManager.LayoutLabel(label, fontSize: 0, fontColor: nil)
        }
        
        static func LayoutTextField_1(txtField:UITextField?)
        {
            RJSLayoutsManager.LayoutTextField(txtField, fontSize: 0, fontColor: nil)
        }
        
        static func LayoutUIButtonSucess_1(btn:UIButton?)
        {
            RJSLayoutsManager.App_Links.LayoutLabel_Title_1(btn?.titleLabel);

            let fontColor = UIColor.redColor();
            RJSLayoutsManager.LayoutUIButton(btn, fontSize: 0, fontColor: fontColor, backgroudImage: nil, backgroundColor: nil, borderSize: 0);
        }
        
        static func LayoutUIButtonDelete_1(btn:UIButton?)
        {
            RJSLayoutsManager.App_Links.LayoutLabel_Title_1(btn?.titleLabel);

            let fontColor  = UIColor.redColor();
            let borderSize = 3;
            RJSLayoutsManager.LayoutUIButton(btn, fontSize: 0, fontColor: fontColor, backgroudImage: nil, backgroundColor:nil, borderSize: borderSize);
        }
        
        static func LayoutUIButtonAction_1(btn:UIButton?)
        {
            RJSLayoutsManager.LayoutUIButton(btn, fontSize: 0, fontColor: UIColor.blueColor(), backgroudImage: nil, backgroundColor: UIColor.cyanColor(), borderSize: 3);
        }
        
        static func LayoutBackgroundLabelOrView(lbl:UILabel?)
        {
            RJSLayoutsManager.layoutBackgroundLabelOrView(lbl, cornerSize:3);
        }
        
        
        static func LayoutUITableViewCell_1(cell:UITableViewCell?)
        {
            if(HaveValue(cell))
            {
                RJSLayoutsManager.LayoutLabel(cell!.textLabel, fontSize: 0, fontColor: nil)
                RJSLayoutsManager.LayoutLabel(cell!.detailTextLabel, fontSize: 0, fontColor: nil)
                cell!.backgroundColor = RJSLayoutsManagerConstants.Default.BackgroundColor
            }
        }
        
        static func LayoutRJSChoices(choices:RJSChoivesVC, tableView:UITableView)
        {
            if(HaveValue(choices))
            {
                tableView.backgroundColor = RJSLayoutsManagerConstants.Default.BackgroundColor;
            }
        }
        
        static func LayoutBackgroundTitleLabel(titleLabel:UILabel?)
        {
            if(HaveValue(titleLabel))
            {
                RJSLayoutsManager.LayoutLabel(titleLabel, fontSize: 12, fontColor: nil)
                titleLabel!.textAlignment   = NSTextAlignment.Center
            }
            else
            {
                DLogWarning("Empty!")
            }
        }
        
        static func LayoutUINavigationBar(appName:String?)
        {
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
    }
}
