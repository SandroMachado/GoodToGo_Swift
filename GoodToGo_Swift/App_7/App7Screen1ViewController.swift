//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

class App7Screen1ViewController: UIViewController {
    
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
        RJSBlocks.executeInMainTread { () -> () in
            let lblTitle = RJSProgramaticControls.getUILabel(self.viewModel?.title)
            RJSLayoutsManager.App7.LayoutLabel_Title_1(lblTitle)
            lblTitle.textAlignment = .Center;
            self.navigationItem.titleView = lblTitle
            self.tableView!.reloadData()
            if(self.refreshControl.refreshing) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let destinationVC = segue.destinationViewController as? App7Screen2ViewController {
            destinationVC.sharedVar = lastSelectedItem
            
            // Override back button text
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
    }

    // MARK: ScroolView
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y;
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let percentage = (currentOffset/maximumOffset) * 100
        print(percentage)
        if ((maximumOffset - currentOffset <= -40.0) || (percentage>66)) {
            App7MarvelAPI.getNexComicsPage()
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
        let noDataText = "No data is currently available.\n\nPlease pull down to refresh."
        guard HaveValue(viewModel) else {
            return tableView.layoutForNoData(noDataText, recordsCount: 0)
        }
        guard HaveValue(viewModel!.tableViewDataSource.count>0) else {
            return tableView.layoutForNoData(noDataText, recordsCount: 0)
        }
        let result = viewModel!.tableViewDataSource[section].count
        return tableView.layoutForNoData(noDataText, recordsCount: result)
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
        
        let cell : App7CustomTVCell = tableView.dequeueReusableCellWithIdentifier(App7CustomTVCellConstants.CellIdentifier, forIndexPath: indexPath) as! App7CustomTVCell
        
        let item = viewModel!.tableViewDataSource[indexPath.section][indexPath.row]

        viewModel!.getCoverImage(item) { (newImage) -> Void in
            cell.img1!.setNewImageWithSmootTransition(newImage)
            cell.lbl1!.text = item.title
            cell.lbl2!.text = item.description
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
        
        // Register custom cell
        App7CustomTVCell.prepareTableView(self.tableView!)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to restore to defaults...")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView!.addSubview(refreshControl) 
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

