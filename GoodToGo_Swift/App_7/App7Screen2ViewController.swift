//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit
import Alamofire // TODO : Delete

class App7Screen2ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    var oncetoken: dispatch_once_t = 0
    
    /// TODO: typo: Commic -> Comic
    @IBOutlet weak var lblComicTitle: UILabel?
    @IBOutlet weak var imgComic: UIImageView?

    @IBOutlet weak var lblBackground1: UILabel?
    @IBOutlet weak var lblBackground2: UILabel?

    var sharedVar : TableItem?

    var viewModel : Screen2ViewModel? {
        didSet {
            //shouldUpdateScreen()
        }
    }
    
    // MARK: IBActions
    @IBAction func handleTap(sender: UITapGestureRecognizer? = nil) {
        changeCoverPicture()
    }
    
    @IBAction func changeCoverPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func uploadCurrentPictToDropBox() {
        RJSDropBoxManager.authorizeFromController(self)
        viewModel?.uploadImageToDropbox()
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        self.dismissViewControllerAnimated(true, completion: {
            
            // Confirm if the user really wants to change the picture
            let alertController = UIAlertController(title: "Alert", message: "Are your sure you want to replace the cover picture?", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                
            }
            
            let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
                self.viewModel?.replaceCoverImageForCurrentCommic(newImage)
            }
            
            alertController.addAction(OKAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true) { }
        })
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
  //      DLogWarning("Comentado")
  //      if let destinationVC = segue.destinationViewController as? App7Screen3ViewController {
  //          destinationVC.sharedVar = self.sharedVar
  //      }
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
        let btn1 = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "changeCoverPicture")
        let btn2 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "uploadCurrentPictToDropBox")

        navigationItem.rightBarButtonItems = [btn1, btn2]
            
        RJSLayoutsManager.App7.LayoutBackgroundLabelOrView(self.lblBackground1)
        RJSLayoutsManager.App7.LayoutBackgroundLabelOrView(self.lblBackground2)
        
        RJSLayoutsManager.App7.LayoutLabel_Title_1(self.lblComicTitle)

        if(HaveValue(self.imgComic))
        {
            self.imgComic!.setCornerRadius(5)
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            self.imgComic!.addGestureRecognizer(tap)
        }
    }
    
    func shouldUpdateScreen() {

        let lblTitle = RJSProgramaticControls.getUILabel(viewModel?.controllerTitle)
        RJSLayoutsManager.App7.LayoutLabel_Title_1(lblTitle)
        lblTitle.textAlignment = .Center;
        self.navigationItem.titleView = lblTitle
        
        RJSOptionalUtils.safeUIElementSetValue(self.lblComicTitle, value: viewModel!.comicTitle)
        viewModel?.getCoverImage({ (newImage) -> Void in
            self.imgComic?.setNewImageWithSmootTransition(newImage, duration:1, ajustSize:true)
        })
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

