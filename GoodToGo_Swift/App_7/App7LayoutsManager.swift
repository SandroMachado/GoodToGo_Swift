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
        
        static func LayoutUITableViewCell_1(cell:App7CustomTVCell?)
        {
            guard HaveValue(cell) else {
                DLogWarning("Ignored...")
                return
            }
            RJSLayoutsManager.LayoutLabel(cell!.lbl1, fontSize: 15, fontColor: nil)
            cell!.lbl1!.setCornerRadius(5)
            cell!.img1!.setCornerRadius(3)
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
        
        static func LayoutNavigationBar()
        {
            // Cor dos botoes
            UIBarButtonItem.appearance().tintColor = RJSLayoutsManagerConstants.Default.LabelsTextColor
            UINavigationBar.appearance().titleTextAttributes = [
                NSFontAttributeName: UIFont(name: RJSLayoutsManagerConstants.FontName.HelveticaNeue_Thin, size: 10)!
            ]
            
            UINavigationBar.appearance().backgroundColor = UIColor.whiteColor()
            UITabBar.appearance().backgroundColor        = UIColor.whiteColor();
            
            UINavigationBar.appearance().barTintColor        = UIColor.whiteColor()
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
            // UINavigationBar buttons color
            UINavigationBar.appearance().tintColor = RJSLayoutsManagerConstants.Default.LabelsTextColor

        }
        

    }
}
