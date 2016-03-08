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
    class App7
    {
        static func LayoutNavigationBar()
        {
            RJSLayoutsManager.LayoutNavigationBar(nil)
        }
        
        static func LayoutBackround_1(view:UIView)
        {
            RJSLayoutsManager.LayoutBackgroundView(view, backgroudImage: nil, backgroundColor: nil)
        }
        
        static func LayoutBackgroundLabelOrView(lbl:UILabel?)
        {
            RJSLayoutsManager.layoutBackgroundLabelOrView(lbl, cornerSize:5);
        }
        
        static func LayoutLabel_Title_1(label:UILabel?)
        {
            RJSLayoutsManager.LayoutLabel(label, fontSize: 18, fontColor: nil)
        }
        
        static func LayoutLabel_Value_1(label:UILabel?)
        {
            RJSLayoutsManager.LayoutLabel(label, fontSize: 14, fontColor: nil)
        }
        
        static func LayoutTextView_1(txtView:UITextView?)
        {
            RJSLayoutsManager.LayoutTextView(txtView, fontSize: 14, fontColor: nil)
        }
        
        static func LayoutUIButtonAction_1(btn:UIButton?)
        {
            RJSLayoutsManager.LayoutUIButton(btn, fontSize: 0, fontColor: UIColor.blueColor(), backgroudImage: nil, backgroundColor: UIColor.cyanColor(), borderSize: 3);
        }
        
        static func LayoutUITableView_1(tableView:UITableView?)
        {
            guard HaveValue(tableView) else {
                DLogWarning("Ignored...")
                return
            }
            tableView?.backgroundColor = UIColor.clearColor()
        }
        
        static func LayoutUITableViewCell_1(cell:UITableViewCell?)
        {
            guard HaveValue(cell) else {
                DLogWarning("Ignored...")
                return
            }
            RJSLayoutsManager.LayoutLabel(cell!.textLabel,       fontSize: 15, fontColor: nil)
            //RJSLayoutsManager.LayoutLabel(cell!.detailTextLabel, fontSize: 13, fontColor: nil)
            cell!.backgroundColor = RJSLayoutsManagerConstants.Default.BackgroundColor
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
