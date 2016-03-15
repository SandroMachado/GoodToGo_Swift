//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var thumbnailImageView: UIImageView?
    @IBOutlet weak var tableView: UITableView?

    var viewModel : ArticleViewModel? {
        didSet {
            shouldUpdateScreen()
        }
    }

    @IBAction func btnFire1Pressed() {
        if(HaveValue(viewModel))
        {
            viewModel!.makeSomeOperation()
        }
    }
    
    @IBAction func btnFire2Pressed() {
        if(HaveValue(viewModel))
        {
            viewModel!.reloadTableViewData()
        }
    }
    
    func shouldUpdateScreen() {
        RJSMessagesManager.showSmallTopMessage("Reloaded...")
        RJSOptionalUtils.safeUIElementSetValue(self.titleLabel, value: viewModel!.title)
        RJSOptionalUtils.safeUIElementSetValue(self.dateLabel, value: viewModel!.date)
        RJSOptionalUtils.safeUIElementSetValue(self.thumbnailImageView, value: viewModel!.thumbnail)
        tableView!.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard HaveValue(viewModel) else {
            return 0
        }
        return viewModel!.tableViewSectionsTitle.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel!.tableViewSectionsTitle[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.tableViewDataSource[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(AppConstants.TableView.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let item                   = viewModel!.tableViewDataSource[indexPath.section][indexPath.row]
        cell.textLabel?.text       = item.title
        cell.detailTextLabel?.text = item.description
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tableView!.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: AppConstants.TableView.cellIdentifier)
        
    }
    
    func loadViewModel()
    {
        guard !HaveValue(viewModel) else {
            DLogWarning("Ignored... Are you calling this 2x?")
            return
        }
        let title = "title \(String.randomStringWithLength(3))"
        let article = Article(title: title, date: NSDate(), image: UIImage())
        viewModel   = ArticleViewModel(article)
        viewModel!.viewNeedsReload.bindAndFire({
            if $0 {
                self.shouldUpdateScreen()
            }
        })
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated);
        
        if isIOSVersion(8)
        {
            self.loadViewModel()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        if isIOSVersion(9)
        {
            self.loadViewModel()
        }
    }
  
}

