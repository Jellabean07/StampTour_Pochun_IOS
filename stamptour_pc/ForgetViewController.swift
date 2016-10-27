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
            let path = HttpReqPath.JoinReq
            let parameters : [ String : AnyObject] = [
                "id" : self.nick_txt.text! as AnyObject,
                "nick" : self.nick_txt.text! as AnyObject
            ]
            self.httpRequest?.connection(path, reqParameter: parameters)
        }
    }
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        alert?.displayMyAlertMessage("\(data)")
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
            let path = HttpReqPath.JoinReq
            let parameters : [ String : AnyObject] = [
                "nick" : self.nick_txt.text! as AnyObject
            ]
            self.httpRequest?.connection(path, reqParameter: parameters)
        }
    }
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        alert?.displayMyAlertMessage("\(data)")
    }
}
