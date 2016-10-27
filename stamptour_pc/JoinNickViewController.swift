//
//  JoinNickViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class JoinNickViewController : UIViewController,UITextFieldDelegate, HttpResponse{
    
    let TAG : String = "JoinNickViewController"
    var chkId : Bool? = false
    var chkNick : Bool? = false
    var httpRequest : HttpRequestToServer?
    
    @IBOutlet var nick_txt: UITextField!

    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    
    @IBAction func nick_overlap_btn(_ sender: AnyObject) {
    }
    
    @IBAction func submit_btn(_ sender: AnyObject) {
    }
    
    @IBAction func terms_btn(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.nick_txt.addTarget(self, action: #selector(self.textFieldDidChangeName(_:)), for: UIControlEvents.editingChanged)
        
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
    }

    func chkNickOverlap(){
        if(self.nick_txt.text != ""){
            if(TextValidation.init().isValidName(self.nick_txt.text)){
                let path = HttpReqPath.JoinNickOverlap
                let parameters : [ String : AnyObject] = [
                    "nick" : self.nick_txt.text! as AnyObject
                ]
                
                self.httpRequest!.connection(path, reqParameter: parameters)
                
            }else{
                ActionDisplay.init(uvc: self).displayMyAlertMessage("6자이내 국문이나 영문으로 입력해주세요")
            }
        }else{
            ActionDisplay.init(uvc: self).displayMyAlertMessage("별명을 입력해주세요")
        }
    }
    
    func textFieldDidChangeName(_ textField: UITextField) {
        self.chkNick = false
        NSLog("중복체크 상태 : \(self.chkNick!)")
    }
    
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        if(reqPath == HttpReqPath.JoinNickOverlap){
            if data == "duplicate"{
                self.chkNick = false
            }else {
                self.chkNick = true
            }
        }else if(reqPath == HttpReqPath.JoinReq){
            
        }
    }
    
}
