//
//  AccountViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 9..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class AcctManagerViewController : UIViewController , HttpResponse{
    
    let msg_invalid = NSLocalizedString("acc_alert_change_pass_not_invalid", comment: "비밀번호는 6~16자 영문 소문자, 숫자를 조합하세요")
    let msg_match = NSLocalizedString("acc_alert_change_pass_not_match", comment: "비밀번호가 일치하지 않습니다")
    let msg_chg_succ = NSLocalizedString("acc_alert_change_success", comment: "정상적으로 비밀번호가 변경 되었습니다")
    let msg_chg_fail = NSLocalizedString("acc_alert_change_fail", comment: "비밀번호 변경중 오류가 발생했습니다")
    let msg_del_succ = NSLocalizedString("acc_alert_delete_success", comment: "정상적으로 회원탈퇴 되었습니다")
    let msg_del_fail = NSLocalizedString("acc_alert_delete_fail", comment: "회원탈퇴중 오류가 발생했습니다")
    let msg_del_chk = NSLocalizedString("acc_alert_delete_check", comment: "정말 삭제 하시겠습니까?")
    
    let TAG : String = "AcctManagerViewController"
    var httpRequest : HttpRequestToServer?
    var httpRequestMode : String?
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var EmailLabel: UILabel!
    @IBOutlet var NickLabel: UILabel!
    @IBOutlet var passwordField: CustomTextField!
    @IBOutlet var passwordRepeatFiled: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        scrollView.contentSize.height = 667
        let loggedCase = UserDefaultManager.init().getIsLoggedCase()
        if(loggedCase == LoggedInCase.normal.hashValue){
            passwordField.isUserInteractionEnabled = true
            passwordRepeatFiled.isUserInteractionEnabled = true
        }else{
            passwordField.isUserInteractionEnabled = false
            passwordRepeatFiled.isUserInteractionEnabled = false
        }
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        let parameters : [ String : String] = [
            "accesstoken" : accesstoken,
            "nick" : nick
        ]
        self.httpRequest?.connection(HttpReqPath.UserInfoReq, reqParameter: parameters)
    }
    
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        if(reqPath == HttpReqPath.UserInfoReq){
            let data = resData["resultData"] as! NSDictionary
            let nick = data["Nick"] as! String
            let id = data["id"] as! String
            
            NSLog("\(self.TAG) nick : \(nick)")
            NSLog("\(self.TAG) id : \(id)")
            if(resCode == "00"){
                if(nick != "" && id != ""){
                    EmailLabel.text = id
                    NickLabel.text = nick
                }else{
                    NSLog(TAG,"UserInfoRequest Fail")
                }
            }
            else{
                NSLog(TAG,"UserInfoRequest Fail")
            }
        }else if(reqPath == HttpReqPath.PasswordChangeReq){
            if(resCode == "00" && resMsg == "SUCCESS"){
                ActionDisplay.init(uvc: self).displayMyAlertMessageAction(msg_chg_succ, action: returnHome)
            }else{
                ActionDisplay.init(uvc: self).displayMyAlertMessageAction(msg_chg_fail, action: returnHome)
            }
        }else if(reqPath == HttpReqPath.UserRemoveReq){
            if(resCode == "00" && resMsg == "SUCCESS"){
                ActionDisplay.init(uvc: self).displayMyAlertMessageAction(msg_del_succ, action: returnHome)
            }else{
                ActionDisplay.init(uvc: self).displayMyAlertMessageAction(msg_del_fail, action: returnHome)
            }
        }
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if(reqPath == HttpReqPath.PasswordChangeReq){
            ActionDisplay.init(uvc: self).displayMyAlertMessageAction(msg_chg_fail, action: returnHome)
            
        }else if(reqPath == HttpReqPath.UserRemoveReq){
            
            ActionDisplay.init(uvc: self).displayMyAlertMessageAction(msg_del_fail, action: returnHome)
            
        }
        
    }
    
    func returnHome(){
       UserDefaultManager.init().loggedOut(uvc: self)
    }
    
    @IBAction func removeUser(_ sender: AnyObject) {
        ActionDisplay.init(uvc: self).displayMyAlertMessageActionYN(msg_del_chk, action: reqAccDelete)
        
    }
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    @IBAction func submit(_ sender: AnyObject) {
        NSLog(TAG, "전송버튼탭")
        httpRequestMode = "Send"
        let password = passwordField.text
        let passwordrepeat = passwordRepeatFiled.text
        if(password_validation(password: password!,passwordrepeat:passwordrepeat!)){
            let nick = UserDefaultManager.init().getUserNick()
            let accesstoken = UserDefaultManager.init().getUserAccessToken()
            let parameters : [ String : String] = [
                "accesstoken" : accesstoken,
                "nick" : nick,
                "password":password!
            ]
            self.httpRequest?.connection(HttpReqPath.PasswordChangeReq, reqParameter: parameters)

        }else{
            return
        }
    }
    
    func reqAccDelete(){
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        let parameters : [ String : String] = [
            "accesstoken" : accesstoken,
            "nick" : nick,
            "devicetoken":"abcd"
        ]
        self.httpRequest?.connection(HttpReqPath.UserRemoveReq, reqParameter: parameters)
    }
    
    func password_validation(password:String,passwordrepeat:String) -> Bool{
        if(password == passwordrepeat){
            if(TextValidation.init().isValidPassword(passwordrepeat)){
                return true
            }else{
                 ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_invalid)
                return false
            }
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_match)
            return false
        }
        return false
    }
}

class AcctIdentifyViewController : UIViewController , HttpResponse{
    
    let TAG : String = "AcctIdentifyViewController"
    var httpRequest : HttpRequestToServer?
    @IBOutlet var pass_txt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
    }
    
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    
    @IBAction func submit(_ sender: AnyObject) {
       let password = pass_txt.text
    }
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
}
