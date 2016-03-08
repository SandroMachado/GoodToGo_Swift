//
//  GoodToGoSwift
//
//  Created by Ricardo Santos on 24/09/15.
//  Copyright © 2015 Ricardo Santos. All rights reserved.
//

import UIKit

/*
 * Use Cases
 *

    let choices = RJSChoivesVC();
    choices.dataSourceArray = allKeys!;
    choices.shouldDismissAfterSelection = true;
    choices.presentFrom(self);

    // MARK: - RJSChoivesVCDelegate
    func rjsChoivesDidSelectRowAtIndexPath(choices:RJSChoivesVC, indexPath:NSIndexPath)
    {

    }
 */

// @objc -> Protocolo é optional
@objc protocol RJSChoivesVCDelegate
{
    optional func rjsChoivesDidSelectRowAtIndexPath(rjsChoive: RJSChoivesVC, indexPath: NSIndexPath);
    
    // Layout
    optional func rjsChoivesLayoutCell(rjsChoive: RJSChoivesVC, cell:UITableViewCell, object:AnyObject);
    optional func rjsChoivesLayoutTableView(rjsChoive: RJSChoivesVC, tableView:UITableView);
}

class RJSChoivesVC: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    /*
     * Privadas
     */
    private let cellKey = "cell";
    private var dataSourceIsArray : Bool = true;
    private var dataSourceIsDic : Bool = false;
    private var canEditRowAtIndexPath : Bool = false;
    private var tableView: UITableView? = nil;

    /*
     * Publicas
     */
    var currentSeletecObject : AnyObject? = nil;
    var delegate:RJSChoivesVCDelegate?;
    var shouldDismissAfterSelection = false;
    var dataSourceArray: [AnyObject] = [""] {
        didSet
        {
            dataSourceIsArray = true
            dataSourceIsDic   = false
        }
        willSet {
        }
    }

    var dataSourceDic: [String:AnyObject] = ["1":"2"] {
        didSet {
            dataSourceIsArray = false
            dataSourceIsDic   = true
        }
        willSet {
        }
    }
    
    // MARK: - Auxiliar
    
    private func updateCurrentObject(indexPath: NSIndexPath) -> Void
    {
        if(dataSourceIsArray)
        {
            currentSeletecObject = self.dataSourceArray[indexPath.row];
        }
        else if(dataSourceIsDic)
        {
            let row              = indexPath.row;
            let allKeys          = [String](dataSourceDic.keys)
            var allKeysSorted    = allKeys.sort(){$0 < $1}
            let aKey : String    = allKeysSorted[row];
            currentSeletecObject = aKey;
        }
    }
    
    // MARK: - Table view delegate
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return canEditRowAtIndexPath
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            DLogWarning("editingStyle == UITableViewCellEditingStyle.Delete")
              //  objects.removeAtIndex(indexPath.row)
             //   tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        else if (editingStyle == UITableViewCellEditingStyle.Insert)
        {
                
        }
    }
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(dataSourceIsArray)
        {
            return dataSourceArray.count;
        }
        else if(dataSourceIsDic)
        {
            return dataSourceDic.keys.count;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellKey, forIndexPath: indexPath) as UITableViewCell?
        
        let row = indexPath.row
        
        var title : String?
        var value : String?
        
        if(dataSourceIsArray)
        {
            title = dataSourceArray[row] as? String
            value = ""
        }
        else if(dataSourceIsDic)
        {
            let allKeys       = [String](dataSourceDic.keys)
            var allKeysSorted = allKeys.sort(){$0 < $1}
            let aKey : String = allKeysSorted[row];
            title             = aKey;
            value = dataSourceDic[aKey]?.description;
        }
        cell!.textLabel?.text = title;
        cell!.detailTextLabel?.text = value;
        
        self.updateCurrentObject(indexPath);
        
        if(HaveValue(delegate))
        {
            delegate!.rjsChoivesLayoutCell!(self, cell:cell!, object:self.currentSeletecObject!);
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        self.updateCurrentObject(indexPath);
        
        if(HaveValue(delegate))
        {
            delegate!.rjsChoivesDidSelectRowAtIndexPath!(self, indexPath:indexPath);
        }
        if(shouldDismissAfterSelection)
        {
            self.dismissViewController(nil);
        }
    }


    // MARK: - Page life cicle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Create our UITableView with our view's frame
        tableView = UITableView(frame: self.view.frame)
        
        // Register our cell's class for cell reuse
        tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellKey)
        
        // Set our source and add the tableview to the view
        tableView!.dataSource = self
        tableView!.delegate = self
        self.view.addSubview(tableView!)
        
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if(HaveValue(delegate))
        {
            delegate!.rjsChoivesLayoutTableView!(self, tableView:tableView!);
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DLogWarning("Memory warning!")
    }

    
}
