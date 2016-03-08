//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit


/**
 * App_2 - ViewController 2
 */
class Screen2: UIViewController {
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {

    }
    
    // MARK: Page Life Cicle
    
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
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }


}

