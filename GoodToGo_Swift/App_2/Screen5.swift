//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/**
 * App_2 - ViewController 5
 */
class Screen5: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        
        RJSMessagesManager.showAlert(sender: self, title: "Alert", message: "Rotate me, I will resize my self acording to the screen!\n\n[CMD]+[->]")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }

}

