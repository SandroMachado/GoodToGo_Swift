//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{    
    func deselectRow(animated: Bool=true) -> Void
    {
        guard HaveValue(self.indexPathForSelectedRow) else {
            DLogWarning("Ignored")
            return
        }
        self.deselectRowAtIndexPath(self.indexPathForSelectedRow!, animated: animated)
    }
    
    func registerCellIdentifier (cellIdentifier:String) -> Void {
        guard !cellIdentifier.isEmpty else {
            DLogWarning("Ignored")
            return
        }
        self.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
    }
    
    // Given somo table whit no records, set's a message in the table for better user experience
    func layoutForNoData(messageToDisplayIfNoRecords:String, recordsCount:Int, noRecordsViewTag:Int=12345) -> Int {
        
        let messageLabel = self.getSubViewWithTag(noRecordsViewTag)
        if(HaveValue(messageLabel)) {
            messageLabel?.removeFromSuperview() // If we have a message, remove it
        }
        
        if (recordsCount>0) {
            self.backgroundView = nil
            self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        }
        else {
            let messageLabel = RJSProgramaticControls.GetUILabel(messageToDisplayIfNoRecords)
            if(!RJSUtils.existsInternetConnection()) {
                messageLabel.text = "\(messageLabel.text)\n(No internet connection...)"
            }
            
            RJSLayoutsManager.layoutBackgroundLabelOrView(messageLabel, cornerSize: 5)
            messageLabel.numberOfLines = 0
            messageLabel.tag           = noRecordsViewTag
            messageLabel.frame         = CGRectMake(0, 0, RJSSizes.Screen.width/2.0, RJSSizes.Screen.height/4.0)
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.center        = CGPointMake(RJSSizes.Screen.width/2.0, RJSSizes.Screen.height/2.0-RJSSizes.UINavigationBar.height)
            self.separatorStyle        = UITableViewCellSeparatorStyle.None;
            
            RJSLayoutsManager.LayoutLabel(messageLabel, fontSize: 15, fontColor: UIColor.darkGrayColor())
            self.addSubview(messageLabel)
        }
        return recordsCount
    }
}


