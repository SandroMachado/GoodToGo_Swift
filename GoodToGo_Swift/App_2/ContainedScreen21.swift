//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/**
 * App_2 - ContainedScreen1
 */
class ContainedScreen21: UIViewController
{
    
    @IBOutlet weak var btn1: UIButton?;

    @IBAction func btn1Pressed()
    {
        RJSMessagesManager.showAlert(sender: self, title: "Alert", message: "btn1Pressed")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        DLog(segue.identifier)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }


}

