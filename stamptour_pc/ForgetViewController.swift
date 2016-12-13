//
//  ForgetViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class ForgetPassViewController : UIViewController, HttpResponse{
    
    let msg_enough = NSLocalizedString("forgot_pass_alert_not_enough", comment: "정보를 모두입력해주세요")
    let msg_succ = NSLocalizedString("forgot_pass_alert_display_temp_password", comment: "임시비밀번호는")
    let msg_fail = NSLocalizedString("forgot_pass_alert_not_find_password", comment: "아이디를 찾을수 없습니다")
    let TAG : String = "ForgetPassViewController"
    var httpRequest : HttpRequestToServer?
    var alert : ActionDisplay?
    
    @IBOutlet var id_txt: CustomTextField!
    @IBOutlet var nick_txt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        self.alert = ActionDisplay.init(uvc: self)
    }
    
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        search()
    }
    
    func search(){
        if ((self.nick_txt.text!.isEmpty) || (self.id_txt.text!.isEmpty))  {
            alert?.displayMyAlertMessage(msg_enough)
        } else{
            let path = HttpReqPath.ForgetPass
            let parameters : [ String : String] = [
                "id" : self.id_txt.text!,
                "nick" : self.nick_txt.text!,
                "loggedincase" : LoggedInCase.normal.description
            ]
            self.httpRequest?.connection(path, reqParameter: parameters)
        }
    }
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        
        alert?.displayMyAlertMessageDismissView("\(msg_succ) [\(data)]")
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        
        ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_fail)
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
}


class ForgetIdViewController : UIViewController, HttpResponse{
    let msg_enough = NSLocalizedString("forgot_id_alert_not_enough", comment: "정보를 모두입력해주세요")
    let msg_succ = NSLocalizedString("forgot_id_alert_display_temp_password", comment: "당신의 계정은")
    let msg_fail = NSLocalizedString("forgot_id_alert_not_find_password", comment: "아이디를 찾을수 없습니다")
    
    let TAG : String = "ForgetIdViewController"
    var httpRequest : HttpRequestToServer?
    var alert : ActionDisplay?
    
    @IBOutlet var nick_txt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        self.alert = ActionDisplay.init(uvc: self)
    }
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    @IBAction func submit(_ sender: AnyObject) {
        search()
    }
    
    func search(){
        if (self.nick_txt.text!.isEmpty) {
            alert?.displayMyAlertMessage(msg_enough)
        } else{
            let path = HttpReqPath.ForgetId
            let parameters : [ String : String] = [
                "nick" : self.nick_txt.text!,
                "loggedincase" : LoggedInCase.normal.description
            ]
            self.httpRequest?.connection(path, reqParameter: parameters)
        }
    }
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        
       alert?.displayMyAlertMessageDismissView("\(msg_succ) [\(data)]")
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        
        ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_fail)
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
}
