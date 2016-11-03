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
            NSLog("메뉴"+indexPath.row.description, "탭");
            moveToAccountManageView();
            break
        case 1:
            NSLog("메뉴"+indexPath.row.description, "탭");
            moveToGiftManageView();
            break
        case 2:
            NSLog("메뉴"+indexPath.row.description, "탭");
            moveToHideManageView();
            break
        case 3:
            NSLog("메뉴"+indexPath.row.description, "탭");
            break
        default: break
            
        }
    }
    func moveToAccountManageView(){
        let loggedCase = UserDefaultManager.init().getIsLoggedCase()
        switch loggedCase {
        case LoggedInCase.normal.hashValue:
            NSLog("normal", LoggedInCase.normal.description)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AcctIdentifyViewController") as! AcctIdentifyViewController
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated:true, completion: nil)
            break
        case LoggedInCase.fbLogin.hashValue:
            NSLog(TAG, LoggedInCase.fbLogin.description)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AcctManagerViewController") as! AcctManagerViewController
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated:true, completion: nil)
            break
        case LoggedInCase.kakaoLogin.hashValue:
            NSLog(TAG, LoggedInCase.kakaoLogin.description)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AcctManagerViewController") as! AcctManagerViewController
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated:true, completion: nil)
            break
        default:
            break
        }
    }
    func moveToGiftManageView(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GiftManageViewController") as! GiftManageViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
        
    }
    func moveToHideManageView(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HideListManageViewController") as! HideListManageViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
        
    }
    func moveToSurveyView(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AcctIdentifyViewController") as! AcctIdentifyViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
        
    }
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        
        UserDefaultManager.init().loggedOut()
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
        
    }

}
