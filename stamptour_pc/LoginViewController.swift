//
//  ViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 22..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate, HttpResponse{

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
        actionList.append(ActionVO(title: "아이디 찾기",action: moveToForgetId))
        actionList.append(ActionVO(title: "비밀번호 찾기",action: moveToForgetPass))
        ActionDisplay.init(uvc: self).displayMyAlertMessesgeList("원하는 정보를 선택하세요", actionList: actionList)
    }
    
    func NomalLogin(){
        let id_value = self.id_txt.text
        let pass_value = self.pass_txt.text
        self.loginCase = LoggedInCase.normal.hashValue;
        if((id_value!.isEmpty||pass_value!.isEmpty)){
            ActionDisplay.init(uvc: self).displayMyAlertMessage("아이디또는 패스워드를 입력해주세요")
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
        
    }
    
    func KOLoggedIn(){
        
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
    
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
        let nick = data["nick"] as! String
        let accesstoken = data["accesstoken"] as! String
        
        NSLog("\(self.TAG) nick : \(nick)")
        
        if(nick != "-1" && accesstoken != "-1"){
            UserDefaultManager.init().loggedIn(self.id_txt.text!, nick: nick, accessToken: accesstoken, LoginCase: self.loginCase!)
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated:true, completion: nil)
        }else{
            NSLog(TAG,"Login Fail")
        }
        
       //go-> main
       
    }
}

