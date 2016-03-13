  //
  //  GoodToGo_Swift
  //
  //  Copyright © 2016 Ricardo Santos. All rights reserved.
  //
  
  import UIKit
  
  enum App7CustomTVCellConstants {
    static var CellIdentifier: String {
        return "App7CustomTVCell_1"
    }
    static var NibName: String {
        return "App7CustomTVCell_1"
    }
    static var CellHeigth: CGFloat {
        return 255
    }
  }
  
  class App7CustomTVCell: UITableViewCell {
    
    @IBOutlet var img1: UIImageView?
    @IBOutlet weak var lbl1: UILabel?
    @IBOutlet weak var lbl2: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
    // Call on ViewDidLoad from the contoller using this classe
    static func prepareTableView(tableView:UITableView?) -> Void {
        guard HaveValue(tableView) else {
            return
        }
        let nib = UINib(nibName: App7CustomTVCellConstants.NibName, bundle: nil)
        tableView!.registerNib(nib, forCellReuseIdentifier: App7CustomTVCellConstants.CellIdentifier)
        tableView!.rowHeight = App7CustomTVCellConstants.CellHeigth
    }
  }