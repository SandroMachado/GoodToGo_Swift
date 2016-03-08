//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 19/09/15.
//  Copyright (c) 2015 Ricardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    func setFontSize(fontSize: CGFloat) -> Void
    {
        self.font = self.font.fontWithSize(fontSize)
    }
}