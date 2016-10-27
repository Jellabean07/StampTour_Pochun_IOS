//
//  MoreViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class MoreViewController : UIViewController ,UITableViewDelegate, UITableViewDataSource, HttpResponse{
    
    let TAG : String = "MoreViewController"
    var httpRequest : HttpRequestToServer?
    var menu : Array = Array<MenuVO>()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        setItem()
    }
    
    @IBAction func logout_btn(_ sender: AnyObject) {
        logout()
    }
 

    func logout(){
        let path = HttpReqPath.LogoutReq
        let parameters : [ String : AnyObject] = [
            "accesstoken" : UserDefaultManager.init().getUserAccessToken() as AnyObject,
        ]
        
        self.httpRequest!.connection(path, reqParameter: parameters)
    }
    
    func setItem(){
        menu.append(MenuVO.init(img: "img_account",title : "계정 관리"))
        menu.append(MenuVO.init(img: "img_gift",title : "선물 신청 및 관리"))
        menu.append(MenuVO.init(img: "img_hiding",title : "숨김 관리"))
        menu.append(MenuVO.init(img: "img_survey",title : "설문 하기"))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    
    func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath)-> UITableViewCell{
        let row = self.menu[(indexPath as NSIndexPath).row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        cell.title.text = row.title!
        cell.img.image = UIImage(named: row.img!)
        
        return cell;
    }
    //item tapped event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default: break
            
        }
    }
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        
        UserDefaultManager.init().loggedOut()
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
        
    }

}
