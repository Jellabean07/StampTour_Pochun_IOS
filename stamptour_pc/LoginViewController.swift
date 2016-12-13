//
//  ViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 22..
//  Copyright © 2016년 thatzit. All rights reserved.
//
import FacebookCore
import FacebookLogin
import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate, HttpResponse{

    let msg_find_id = NSLocalizedString("login_alert_find_id", comment: "아이디 찾기")
    let msg_find_pass = NSLocalizedString("login_alert_find_pass", comment: "비밀번호 찾기")
    let msg_title = NSLocalizedString("login_alert_find_title", comment: "아이디 및 비밀번호 찾기")
    let msg_subtitle = NSLocalizedString("login_alert_find_subtitle", comment: "원하는 정보를 선택하세요")
    let msg_enough = NSLocalizedString("login_alert_not_enough", comment: "아이디또는 패스워드를 입력해주세요")
    let msg_fail = NSLocalizedString("login_alert_fail", comment: "로그인중 오류가 발생했습니다")
    let msg_match = NSLocalizedString("login_alert_match", comment: "아이디 또는 비밀번호가 잘못되었습니다")
    
    let TAG : String = "LoginViewController"
    var httpRequest : HttpRequestToServer?
    var loginCase : Int?
    var nick : String?
    
    @IBOutlet var id_txt: UITextField!
    @IBOutlet var pass_txt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)

    }
    
    @IBAction func NormalLoginBtn(_ sender: AnyObject) {
        NomalLogin()
    }
    
    @IBAction func FBLoginBtn(_ sender: AnyObject) {
        FBLoggedin()
    }
    
    @IBAction func KOLoginBtn(_ sender: AnyObject) {
        KOLoggedIn()
    }
    
    @IBAction func join_btn(_ sender: AnyObject) {
    }
    
    @IBAction func forget_btn(_ sender: AnyObject) {
        var actionList = Array<ActionVO>()
        actionList.append(ActionVO(title: msg_find_id  ,action: moveToForgetId))
        actionList.append(ActionVO(title: msg_find_pass ,action: moveToForgetPass))
        ActionDisplay.init(uvc: self).displayMyAlertMessesgeList(msg_title,userMessege : msg_subtitle, actionList: actionList)
    }
    
    func NomalLogin(){
        self.dismissKeyboard()
        let id_value = self.id_txt.text
        let pass_value = self.pass_txt.text
        self.loginCase = LoggedInCase.normal.hashValue;
        if((id_value!.isEmpty||pass_value!.isEmpty)){
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_enough)
            return;
        }
        else
        {
            let path = HttpReqPath.LoginReq
            let parameters : [ String : String] = [
                "loggedincase" : LoggedInCase.normal.description,
                "id" : id_value!,
                "password" : pass_value!
            ]
            
            self.httpRequest!.connection(path, reqParameter: parameters)
        }
    }
    
    func FBLoggedin(){
        FBManager.init(uvc: self).login()
    }
    
    func KOLoggedIn(){
        KOManager.init(uvc: self).getReturnState()
    }
    
    func moveToForgetId(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgetIdViewController") as! ForgetIdViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
        
    }
    
    func moveToForgetPass(){
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPassViewController") as! ForgetPassViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
        
    }
    
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
        let nick = data["nick"] as! String
        let accesstoken = data["accesstoken"] as! String
        
        NSLog("\(self.TAG) nick : \(nick)")
        NSLog("\(self.TAG) accesstoken : \(accesstoken)")
        
        if(nick != "-1" && accesstoken != "-1"){
            UserDefaultManager.init().loggedIn(self, id: self.id_txt.text!, nick: nick, accessToken: accesstoken, LoginCase: self.loginCase!)
            
            
            
        }else {
            NSLog(TAG,"Login Fail")
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_match)
        }
        
        
       //go-> main
       
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
          ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_fail)
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
}

