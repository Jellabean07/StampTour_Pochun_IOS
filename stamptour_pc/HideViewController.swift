//
//  HideListManageViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 3..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class HideViewController : UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    let TAG : String = "HideViewController"
    var httpRequest : HttpRequestToServer?
    var towns : [TownVO]?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setTowns()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTowns()
    }
    
    
    func setTowns(){
        self.towns = StampDefaultManager.init().getTowns()
        self.tableView.reloadData()
    }
    
    @IBAction func pop(_ sender: Any) {
         CommonFunction.dismiss(self)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.towns!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.towns![(indexPath as NSIndexPath).row];
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "HideCell") as! HideCell
        
        cell.thumbnail.image = row.images[0].circle
        cell.name.text = row.title
        cell.region.text = "\(row.region)"
        cell.hideClear.tag = indexPath.row
        cell.hideClear.addTarget(self, action: #selector(hideClearedFromBtn), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    
    func hideClearedFromBtn(sender : UIButton!) {
        let buttonRow = sender.tag
        self.towns![buttonRow].hidden = false
        StampDefaultManager.init().deleteHideItem(townCode: self.towns![buttonRow].code)
        StampDefaultManager.init().setTowns(towns: self.towns!)
        var indexPath = NSIndexPath(row: buttonRow, section: 0)
        self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.right)
            
        
        print("\(TAG) : hideClearFromBtnAction : \(buttonRow)")
    }
    
  
    
    

   
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let hide = UITableViewRowAction(style: .normal, title: "숨김") { action, index in
//            print("\(self.TAG) : hide button tapped : \(index)")
//            self.hide(index)
//        }
//        hide.backgroundColor = UIColor.red
//        
//        
//        return [hide]
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.towns![(indexPath as NSIndexPath).row];
        var rowHeight:CGFloat = 0.0
        
        if(row.hidden){
            rowHeight = 80.0
        }else{
            //rowHeight = UITableViewAutomaticDimension
            rowHeight = 0.0    //or whatever you like
        }
        
        return rowHeight
    }
}
