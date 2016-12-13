//
//  JoinNickViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class JoinNickViewController : UIViewController,UITextFieldDelegate, HttpResponse{
    
    let msg_duplicate = NSLocalizedString("join_social_alert_join_confirm_nick_need_duplicate", comment: "별명중복확인이 필요합니다")
    let msg_trim = NSLocalizedString("join_social_alert_join_confirm_trim_input", comment: "빈칸을 모두 채워주세요")
    let msg_nick_invalid = NSLocalizedString("join_social_alert_check_duplicate_nick_not_invalid", comment: "6자이내 영문,국문 유효성 검사")
    let msg_nick_trim = NSLocalizedString("join_social_alert_check_duplicate_nick_trim_input", comment: "별명을 입력해주세요")
    let msg_nick_dupl = NSLocalizedString("join_social_alert_check_duplicate_nick_duplicate", comment: "중복된 별명입니다")
    let msg_nick_not_dupl = NSLocalizedString("join_social_alert_check_duplicate_nick_not_duplicate", comment: "사용할 수 있는 별명입니다")
    
    let TAG : String = "JoinNickViewController"
    var chkNick : Bool? = false
    var httpRequest : HttpRequestToServer?
    var loggedInCase : LoggedInCase?
    var userId : String?
    
    
    @IBOutlet var nick_txt: UITextField!

    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    
    @IBAction func nick_overlap_btn(_ sender: AnyObject) {
        chkNickOverlap()
    }
    
    @IBAction func submit_btn(_ sender: AnyObject) {
        join()
    }
    
    @IBAction func terms_btn(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.nick_txt.addTarget(self, action: #selector(self.textFieldDidChangeName(_:)), for: UIControlEvents.editingChanged)
        
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
    }

    func join(){
        let nick = self.nick_txt.text?.trimmingCharacters(in: .whitespaces)
        if (!(nick == "")){
                if(self.chkNick! == true){
                    let path = HttpReqPath.JoinReq
                    let parameters : [ String : String] = [
                        "loggedincase" : (loggedInCase?.description)!,
                        "id" : self.userId!,
                        "nick" : nick!
                    ]
                    self.httpRequest?.connection(path, reqParameter: parameters)
                    
                    
                }else{
                    ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_duplicate)
                }
          
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_trim)
        }
    }
    
    func chkNickOverlap(){
        let nick = self.nick_txt.text?.trimmingCharacters(in: .whitespaces)
        if(nick != ""){
            if(TextValidation.init().isValidName(nick)){
                let path = HttpReqPath.JoinNickOverlap
                let parameters : [ String : String] = [
                    "nick" : nick!
                ]
                
                self.httpRequest!.connection(path, reqParameter: parameters)
                
            }else{
                ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_invalid)
            }
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_trim)
        }
    }
    
    func textFieldDidChangeName(_ textField: UITextField) {
        self.chkNick = false
        NSLog("중복체크 상태 : \(self.chkNick!)")
    }
    
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        
        if(reqPath == HttpReqPath.JoinNickOverlap){
            let data = resData["resultData"] as! String
            if data == "duplicate"{
                ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_dupl)
                self.chkNick = false
            }else {
                ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_ncik_not_dupl)
                self.chkNick = true
            }
        }else if(reqPath == HttpReqPath.JoinReq){
            let path = HttpReqPath.LoginReq
            let parameters : [ String : String] = [
                "loggedincase" : (loggedInCase?.description)!,
                "id" : self.userId!
            ]
            
            self.httpRequest!.connection(path, reqParameter: parameters)
        }else if(reqPath == HttpReqPath.LoginReq){
            let data = resData["resultData"] as! NSDictionary
            let nick = data["nick"] as! String
            let accesstoken = data["accesstoken"] as! String
            
            NSLog("\(self.TAG) nick : \(nick)")
            NSLog("\(self.TAG) accesstoken : \(accesstoken)")
            
            if(!(nick == "-1" && accesstoken == "-1")) {
                 print("\(TAG) : Oauth login success")
                 UserDefaultManager.init().loggedIn(self, id: self.userId!, nick: nick, accessToken: accesstoken, LoginCase: loggedInCase!.hashValue)
            }else{
                print("\(TAG) : Oauth login fail")
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let navController = UINavigationController(rootViewController: viewController)
                self.present(navController, animated:true, completion: nil)
            }
        }
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
}
