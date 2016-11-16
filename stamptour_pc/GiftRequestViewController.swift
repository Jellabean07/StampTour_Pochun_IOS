//
//  GiftRequestViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 10..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class GiftRequestViewController: UIViewController,HttpResponse {
    
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    let TAG : String = "GiftRequestViewController"
    var httpRequest : HttpRequestToServer?
    var grade : String!
    var stamp_count : Int!
    var sourceViewController :GiftManageViewController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        
    }
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
        if (reqPath == HttpReqPath.UserGiftApply) {
            let event = GiftRequestEvent.init(status: true, giftSendDelegate: self.sourceViewController)
            event.refresh()
            ActionDisplay.init(uvc: self).displayMyAlertMessageDismissView("선물신청 성공")
            
//            CommonFunction.dismiss(self)
        }
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
    @IBAction func pop(_ sender: AnyObject) {
        let event = GiftRequestEvent.init(status: false, giftSendDelegate: sourceViewController)
        event.refresh()
        CommonFunction.dismiss(self)
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        let name = nameTextField.text?.description
        let phone = phoneTextField.text?.description
        
//        NSLog(nick+"\n"+name!+"\n"+accesstoken+"\n"+phone!+"\n"+self.grade+"\n"+self.stamp_count.description)
        
        
        let parameters : [ String : String] = [
            "accesstoken" : accesstoken,
            "nick" : nick,
            "realName" : name!,
            "phone": phone!,
            "grade": grade,
            "stamp_count":stamp_count.description
        ]
        self.httpRequest?.connection(HttpReqPath.UserGiftApply, reqParameter: parameters)
    }
}
