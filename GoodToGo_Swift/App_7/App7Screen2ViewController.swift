//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit
import Alamofire // TODO : Delete

class App7Screen2ViewController: UIViewController {
 
    var oncetoken: dispatch_once_t = 0
    
    /// FIX: 
    @IBOutlet weak var txtCommicDescription: UITextView?
    @IBOutlet weak var lblCommicTitle: UILabel?
    @IBOutlet weak var imgCommic: UIImageView?

    @IBOutlet weak var lblBackground1: UILabel?
    @IBOutlet weak var lblBackground2: UILabel?
    @IBOutlet weak var lblBackground3: UILabel?

    var sharedVar : TableItem?

    var viewModel : Screen2ViewModel? {
        didSet {
            //shouldUpdateScreen()
        }
    }
    
    // MARK: IBActions

    // Handles tap on lblUserName
    @IBAction func handleTap(sender: UITapGestureRecognizer? = nil) {
       // let segueId      = App7Constants.Segues.Screen3
       // performSegueWithIdentifier(segueId, sender: nil)
    

    }
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        DLogWarning("Comentado")
      //  if let destinationVC = segue.destinationViewController as? Screen3ViewController {
      //      destinationVC.sharedVar = self.sharedVar
      //  }
    }
    
    // MARK: Auxiliar
    
    func loadViewModel()
    {
        guard !HaveValue(viewModel) else {
            DLogWarning("Ignored... Are you calling this 2x?")
            return
        }
        viewModel = Screen2ViewModel(item: sharedVar!)
        viewModel!.viewNeedsReload.bindAndFire({
            if $0 {
                self.shouldUpdateScreen()
            }
        })
    }
    
    func prepareLayout()
    {
        
        RJSLayoutsManager.App7.LayoutBackgroundLabelOrView(self.lblBackground1)
        RJSLayoutsManager.App7.LayoutBackgroundLabelOrView(self.lblBackground2)
        RJSLayoutsManager.App7.LayoutBackgroundLabelOrView(self.lblBackground3)
        
        RJSLayoutsManager.App7.LayoutLabel_Title_1(self.lblCommicTitle)
        RJSLayoutsManager.App7.LayoutTextView_1(self.txtCommicDescription)

        if(HaveValue(self.imgCommic))
        {
            self.imgCommic!.setCornerRadius(5)
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            self.imgCommic!.addGestureRecognizer(tap)
        }
    }
    
    func shouldUpdateScreen() {

        let lblTitle = RJSProgramaticControls.GetUILabel(viewModel?.controllerTitle)
        RJSLayoutsManager.App7.LayoutLabel_Title_1(lblTitle)
        lblTitle.textAlignment = .Center;
        self.navigationItem.titleView = lblTitle
        
        RJSOptionalUtils.safeUIElementSetValue(self.lblCommicTitle, value: viewModel!.articleTitle)

        RJSOptionalUtils.safeUIElementSetValue(self.txtCommicDescription, value: viewModel!.body)
        RJSOptionalUtils.safeUIElementSetValue(self.imgCommic,            value: viewModel!.coverImage)
    }
    
    // MARK: Page life cicle

    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated);
        // Avoid to re-prepareLayout layout and modelview more thant once (when we came back from the map)
        dispatch_once(&oncetoken) {
            self.loadViewModel()
            self.prepareLayout()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        RJSDropBoxManager.uploadImage(AppGenericConstants.APIs.DropboxAcessTokenSecret, image:self.imgCommic!.image!) { (result, error) -> Void in
            print(result)
        }
    }

}

