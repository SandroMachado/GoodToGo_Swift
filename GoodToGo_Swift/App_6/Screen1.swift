//
//  GoodToGo_Swift
//
//  Created by Ricardo Santos on 11/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import UIKit
import RealmSwift

/**
 * App_6 - Screen 1
 */
class Screen1: UIViewController {
    @IBOutlet weak var tableView: UITableView?;
    var tableViewDataSource = [TableItem]();
    
    // MARK: IBActions
    @IBAction func btn2Pressed() -> Void {
        RJSMessagesManager.showSmallTopMessage("Users deleted from DB")
        DBTableUsers.deleteAllRecords() // If we received values, lets delete the old ones...
        self.reloadTableView()
    }
    
    @IBAction func btn1Pressed() -> Void {
        guard RJSUtils.existsInternetConnection() else {
            RJSMessagesManager.showNoInternetConnetion()
            return
        }
        let download1Users = {
            RJSWebservices.asynchonousRequest(App6Constants.URL.Users) { (result, error) -> Void in
                if(HaveValue(result))  {
                    for post in result as! NSArray {
                        autoreleasepool {
                            DBTableUsers(dic:post as! [String : AnyObject]).save()
                        }
                    }
                }
                else {
                    RJSErrorsManager.handleError(error)
                }
                RJSMessagesManager.showSmallTopMessage("Users donwload and stored...")
                self.reloadTableView()
            };
        }
        download1Users()
    }
    
    // MARK: Auxiliar
    func reloadTableView()-> Void {
        guard HaveValue(self.tableView) else  {
            DLogWarning("Ignored...")
            return
        }
        
        RJSBlocks.executeInMainTread { () -> () in
            self.tableViewDataSource.removeAll()
            for user in DBTableUsers.allRecords()
            {
                self.tableViewDataSource.append(TableItem(title: user.name, description: "", id: user.id))
            }
            if(HaveValue(self.tableView)) {
                self.tableView!.reloadData()
            }
        }
    }
    
    // MARK: UITableView delegate
    var lastSelectedItem : TableItem?
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        lastSelectedItem = tableViewDataSource[indexPath.section]
        DBTableUsers.deleteRecordWithId(RJSConvert.convertToInt(lastSelectedItem?.id))
        RJSMessagesManager.showSmallTopMessage("Record deleted")
        self.reloadTableView()
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(tableViewDataSource.count) stored users"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(AppGenericConstants.TableView.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let item                   = tableViewDataSource[indexPath.row]
        cell.textLabel?.text       = item.title
        cell.detailTextLabel?.text = item.description
        return cell
    }
    
    // MARK: Page life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.registerCellIdentifier(AppGenericConstants.TableView.cellIdentifier)
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        self.reloadTableView()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }


}

