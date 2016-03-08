//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

/**
 * App_2 - ViewController 1
 */
class Screen1: UIViewController {

    @IBOutlet weak var imgView1: UIImageView?;
    @IBOutlet weak var btn: UIButton?;

    @IBAction func btnPressed()
    {
        let segueId = App2Constants.Segues.VC3
        performSegueWithIdentifier(segueId, sender: nil)
    }

    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        DLog(segue.identifier)
        let segueId = ToString(segue.identifier)
        RJSMessagesManager.showSmallTopMessage("segue.identifier : \(segueId)")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated);
        
        if(HaveValue(imgView1))
        {
            RJSBlocks.executeWithDelay(Tread.MainTread, delay: 1, block: {
                self.imgView1!.bump(size:5)
            })
            
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }


}

