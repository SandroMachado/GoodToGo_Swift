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
}


