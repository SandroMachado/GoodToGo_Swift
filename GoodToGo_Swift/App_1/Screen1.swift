//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit
import Eureka



/**
 * App_1 - ViewController 1
 */
class Screen1: UIViewController {

    @IBOutlet weak var imgView1: UIImageView?;
    @IBOutlet weak var imgView2: UIImageView?;
    @IBOutlet weak var imgView3: UIImageView?;
    
    @IBAction func btn1Pressed() -> Void
    {
        
        // Animacao 1
        self.imgView2!.bump();
        
        // Animacao 2
        self.imgView3!.fadeOutAndInAgain(0.1, duration: 1);
        
        // Preparar animacao 3
        self.imgView1!.center = CGPoint(x: RJSSizes.Screen.width/2, y: RJSSizes.Screen.height/2)
        self.imgView1?.alpha = 0
        
        // Fazer animação 3
        let duration = 0.72;
        let delay    = 0.3;
        UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: 0.46, initialSpringVelocity: 0.1, options: [], animations: {
            self.imgView1!.alpha = 1
            self.imgView1!.center = CGPoint(x: self.imgView1!.center.x, y: self.imgView1!.center.y-100)
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        
       // self.btnResetAnimations();
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }


}

