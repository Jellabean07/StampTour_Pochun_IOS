//
//  ForgetViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class ForgetPassViewController : UIViewController, HttpResponse{
    
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
            alert?.displayMyAlertMessage("정보를 모두 입력해주세요")
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
        alert?.displayMyAlertMessageDismissView("임시 비밀번호는 [\(data)] 입니다")
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
         ActionDisplay.init(uvc: self).displayMyAlertMessage("비빌번호를 찾을 수 가 없습니다")
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
}


class ForgetIdViewController : UIViewController, HttpResponse{
    
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
            alert?.displayMyAlertMessage("정보를 모두 입력해주세요")
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
       alert?.displayMyAlertMessageDismissView("당신의 계정은 [\(data)] 입니다 ")
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        ActionDisplay.init(uvc: self).displayMyAlertMessage("아이디를 찾을 수 가 없습니다")
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
}
