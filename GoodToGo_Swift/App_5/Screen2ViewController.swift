//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

class Screen2ViewController: UIViewController {
 
    var oncetoken: dispatch_once_t = 0
    
    @IBOutlet weak var txtBody: UITextView?
    @IBOutlet weak var lblUserName: UILabel?
    @IBOutlet weak var lblArticleTitle: UILabel?
    @IBOutlet weak var lblComentsCount: UILabel?
    @IBOutlet weak var imgAvatar: UIImageView?

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
        let segueId      = App5Constants.Segues.Screen3
        performSegueWithIdentifier(segueId, sender: nil)
    }
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let destinationVC = segue.destinationViewController as? Screen3ViewController {
            destinationVC.sharedVar = self.sharedVar
        }
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
        
        RJSLayoutsManager.App5.LayoutBackgroundLabelOrView(self.lblBackground1)
        RJSLayoutsManager.App5.LayoutBackgroundLabelOrView(self.lblBackground2)
        RJSLayoutsManager.App5.LayoutBackgroundLabelOrView(self.lblBackground3)
        
        RJSLayoutsManager.App5.LayoutLabel_Value_1(self.lblUserName)
        RJSLayoutsManager.App5.LayoutLabel_Title_1(self.lblArticleTitle)
        RJSLayoutsManager.App5.LayoutLabel_Value_1(self.lblComentsCount)
        RJSLayoutsManager.App5.LayoutTextView_1(self.txtBody)

        if(HaveValue(self.imgAvatar))
        {
            self.imgAvatar!.setCornerRadius(5)
        }
    }
    
    func shouldUpdateScreen() {

        let lblTitle = RJSProgramaticControls.getUILabel(viewModel?.controllerTitle)
        RJSLayoutsManager.App5.LayoutLabel_Title_1(lblTitle)
        lblTitle.textAlignment = .Center;
        self.navigationItem.titleView = lblTitle
        
        RJSOptionalUtils.safeUIElementSetValue(self.lblUserName,     value: viewModel!.username)
        RJSOptionalUtils.safeUIElementSetValue(self.lblArticleTitle, value: viewModel!.articleTitle)

        RJSOptionalUtils.safeUIElementSetValue(self.txtBody,         value: viewModel!.body)
        RJSOptionalUtils.safeUIElementSetValue(self.lblUserName,     value: viewModel!.username)
        RJSOptionalUtils.safeUIElementSetValue(self.lblComentsCount, value: viewModel!.commentsCount)
        RJSOptionalUtils.safeUIElementSetValue(self.imgAvatar,       value: viewModel!.avatar)
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
    }

}

