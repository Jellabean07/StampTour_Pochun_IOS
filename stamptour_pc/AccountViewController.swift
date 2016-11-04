//
//  AccountViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 9..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class AcctManagerViewController : UIViewController , HttpResponse{
    
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
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        let parameters : [ String : String] = [
            "accesstoken" : accesstoken,
            "nick" : nick
        ]
        httpRequestMode = "Render";
        self.httpRequest?.connection(HttpReqPath.UserInfoReq, reqParameter: parameters)
    }
    
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        if(httpRequestMode == "Render"){
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
        }else if(httpRequestMode == "Send"){
            
        }
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
    func password_validation(password:String,passwordrepeat:String) -> Bool{
        if(password == passwordrepeat){
            if(TextValidation.init().isValidPassword(passwordrepeat)){
                return true
            }else{
                 ActionDisplay.init(uvc: self).displayMyAlertMessage("비밀번호는 6~16자 영문 소문자, 숫자를 조합하세요")
                return false
            }
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage("비밀번호가 일치하지 않습니다")
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
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
}
