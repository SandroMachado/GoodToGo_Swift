//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

class Screen1ViewController: UIViewController {
    
    var oncetoken: dispatch_once_t = 0

    @IBOutlet weak var tableView: UITableView?

    var refreshControl: UIRefreshControl!
    var viewModel : Screen1ViewModel? {
        didSet {
         //   shouldUpdateScreen()
        }
    }
    
    // MARK: Auxiliar
    
    func refresh(sender:AnyObject?) {
        viewModel?.refreshAllData()
    }
    
    func prepareLayout() {
        RJSLayoutsManager.App7.LayoutBackround_1(self.view)
        RJSLayoutsManager.App7.LayoutUITableView_1(self.tableView)
    }
    
    func loadViewModel() {
        guard !HaveValue(viewModel) else {
            DLogWarning("Ignored... Are you calling this 2x?")
            return
        }
        viewModel = Screen1ViewModel()
        viewModel!.viewNeedsReload.bindAndFire({
            if $0 {
                self.shouldUpdateScreen()
            }
        })
    }
    
    func shouldUpdateScreen() {
        let lblTitle = RJSProgramaticControls.GetUILabel(viewModel?.title)
        RJSLayoutsManager.App7.LayoutLabel_Title_1(lblTitle)
        lblTitle.textAlignment = .Center;
        self.navigationItem.titleView = lblTitle
        tableView!.reloadData()
        if(self.refreshControl.refreshing) {
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let destinationVC = segue.destinationViewController as? Screen2ViewController {
            destinationVC.sharedVar = lastSelectedItem
            
            // Override back button text
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    }

    // MARK: UITableView delegate
    var lastSelectedItem : TableItem?
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        lastSelectedItem = viewModel!.tableViewDataSource[indexPath.section][indexPath.row]
        let segueId      = App7Constants.Segues.Screen2
        performSegueWithIdentifier(segueId, sender: nil)
        tableView.deselectRow()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard HaveValue(viewModel) else {
            return 0
        }
        guard HaveValue(viewModel!.tableViewDataSource.count>0) else {
            return 0
        }
        let result = viewModel!.tableViewDataSource[section].count
        return result
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard HaveValue(viewModel) else {
            return 0
        }
        let result = viewModel!.tableViewSectionsTitle.count
        return result
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard HaveValue(viewModel) else {
            return ""
        }
        let result = viewModel!.tableViewSectionsTitle[section]
        return result
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(AppGenericConstants.TableView.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let item                   = viewModel!.tableViewDataSource[indexPath.section][indexPath.row]
        cell.textLabel?.text       = item.title
        cell.detailTextLabel?.text = item.description
        
  
        // Check for user Avatar image
        var imageName = item.thumbnail.replace(":", newChar: "").replace("\\", newChar: "").replace("/", newChar: "")
        imageName = "comic_cover\\" + imageName
        let avatarImage = RJSFilesManager.getImage(imageName)
        
        if(HaveValue(avatarImage)) {
            // We find the avatar image on the file system!
            cell.imageView?.image = avatarImage
        }
        else {
            if(RJSUtils.existsInternetConnection())
            {
                // We didnt find the avatar image on the file system. Let fetch it....
                RJSDownloadsManager.downloadImage(item.thumbnail) { (result, error) -> Void in
                    if(HaveValue(error) && !HaveValue(result)) {
                        RJSErrorsManager.handleError(error)
                        // Error? Return a defautl image...
                        cell.imageView?.image = UIImage(named: App7Constants.Misc.DefaultAvatarImage)
                    }
                    else {
                        // Set the image
                        cell.imageView?.image = result
                        // Cache the image for future use
                        RJSFilesManager.saveImage(imageName, folder: RJSFilesManager.Folder.Documents, image: result)
                    }
                }
            }
            else {
                // No internet connection to download image. Using default
                cell.imageView?.image = UIImage(named: App7Constants.Misc.DefaultAvatarImage)
            }
        }
       
        RJSLayoutsManager.App7.LayoutUITableViewCell_1(cell)
        return cell
    }
   
    // MARK: Notifications

    func startListenningNotification () {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "handleNotification:",
            name: App7Constants.Notifications.ShowNoInternetConnection,
            object: nil)
    }
    
    @objc func handleNotification(sender:AnyObject) {
        RJSMessagesManager.showNoInternetConnetion(self)
    }
    
    // MARK: Page life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad();
    
        startListenningNotification()
        
        self.tableView!.registerCellIdentifier(AppGenericConstants.TableView.cellIdentifier)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView!.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated);
        
        // Avoid to re-prepareLayout layout and modelview more thant once (when we came back from details)
        dispatch_once(&oncetoken) {
            self.loadViewModel()
            self.prepareLayout()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
    }
  
}

