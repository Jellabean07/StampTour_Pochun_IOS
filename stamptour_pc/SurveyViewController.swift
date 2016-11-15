//
//  SurveyViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 15..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class SurveyViewController : UIViewController , HttpResponse{
    
    let TAG : String = "GiftManageViewController"
    var httpRequest : HttpRequestToServer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        
    }
    
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    @IBAction func submit(_ sender: AnyObject) {
//        let nick = UserDefaultManager.init().getUserNick()
//        let accesstoken = UserDefaultManager.init().getUserAccessToken()
//        let name = nameTextField.text?.description
//        let phone = phoneTextField.text?.description
//        
//        //        NSLog(nick+"\n"+name!+"\n"+accesstoken+"\n"+phone!+"\n"+self.grade+"\n"+self.stamp_count.description)
//        
//        
//        let parameters : [ String : String] = [
//            "accesstoken" : accesstoken,
//            "nick" : nick,
//            "realName" : name!,
//            "phone": phone!,
//            "grade": grade,
//            "stamp_count":stamp_count.description
//        ]
//        self.httpRequest?.connection(HttpReqPath.UserGiftApply, reqParameter: parameters)
    }
}
