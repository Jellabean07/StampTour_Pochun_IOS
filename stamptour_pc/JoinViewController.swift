//
//  JoinViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class JoinViewController : UIViewController, UITextFieldDelegate, HttpResponse{
    
    let msg_id_inval = NSLocalizedString("join_alert_check_duplicate_id_not_email", comment: "이메일 형식")
    let msg_id_trim = NSLocalizedString("join_alert_check_duplicate_id_trim_input", comment: "빈칸")
    let msg_nick_inval = NSLocalizedString("join_alert_check_duplicate_nick_not_invalid", comment: "유효성검사")
    let msg_nick_trim = NSLocalizedString("join_alert_check_duplicate_nick_trim_input", comment: "빈칸")
    let msg_trim = NSLocalizedString("join_alert_join_confirm_trim_input", comment: "빈칸")
    let msg_id_chk = NSLocalizedString("join_alert_join_confirm_id_need_duplicate", comment: "아이디 중복확인 필요")
    let msg_nick_chk = NSLocalizedString("join_alert_join_confirm_nick_need_duplicate", comment: "별명 중복확인 필요")
    let msg_pass_match = NSLocalizedString("join_alert_join_confirm_pass_not_match", comment: "비밀번호 불일치")
    let msg_pass_inval = NSLocalizedString("join_alert_join_confirm_pass_not_invalid", comment: "6자이내 영문,국문 유효성 검사")
    let msg_succ = NSLocalizedString("join_alert_join_confirm_success", comment: "회원가입완료")
    let msg_nick_not_dupl = NSLocalizedString("join_alert_check_duplicate_nick_not_duplicate", comment: "별명 사용가능")
    let msg_nick_dupl = NSLocalizedString("join_alert_check_duplicate_nick_duplicate", comment: "별명 중복")
    let msg_id_not_dupl = NSLocalizedString("join_alert_check_duplicate_id_not_duplicate", comment: "아아디 사용가능")
    let msg_id_dupl = NSLocalizedString("join_alert_check_duplicate_id_duplicate", comment: "아이디 중복")
    
    
    let TAG : String = "JoinViewController"
    var chkId : Bool? = false
    var chkNick : Bool? = false
    var httpRequest : HttpRequestToServer?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var id_txt: UITextField!
    @IBOutlet var nick_txt: UITextField!
    @IBOutlet var pass_txt: UITextField!
    @IBOutlet var repass_txt: UITextField!
    @IBOutlet var terms_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        

        let attr = self.terms_btn.titleLabel?.text?.html2AttributedString
        self.terms_btn.setAttributedTitle(attr, for: .normal)
        
        self.id_txt.addTarget(self, action: #selector(self.textFieldDidChangeId(_:)), for: UIControlEvents.editingChanged)
        self.nick_txt.addTarget(self, action: #selector(self.textFieldDidChangeName(_:)), for: UIControlEvents.editingChanged)
        
        scrollView.contentSize.height = 667
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
       
    }
  
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    
    @IBAction func id_overlap_btn(_ sender: AnyObject) {
        self.chkIdOverlap()
    }
    
    @IBAction func nick_overlap_btn(_ sender: AnyObject) {
        self.chkNickOverlap()
    }
    
    @IBAction func submit_btn(_ sender: AnyObject) {
        self.join()
    }
    
    
    func textFieldDidChangeId(_ textField: UITextField) {
        self.chkId = false
        NSLog("중복체크 상태 : \(self.chkId!)")
    }
    
    func textFieldDidChangeName(_ textField: UITextField) {
        self.chkNick = false
        NSLog("중복체크 상태 : \(self.chkNick!)")
    }
    
    func chkIdOverlap(){
        let id = self.id_txt.text?.trimmingCharacters(in: .whitespaces)
       
        if(id != ""){
            if(TextValidation.init().isValidEmail(id)){
                
                let path = HttpReqPath.JoinIdOverlap
                let parameters : [ String : String] = [
                    "id" : id!
                ]
                
                self.httpRequest!.connection(path, reqParameter: parameters)
                
            }else{
                
                ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_id_inval)
            }
        }else{
            
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_id_trim)
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
                
                ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_inval)
            }
        }else{
            
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_trim)
        }
    }
    
    func join(){
        let id = self.id_txt.text?.trimmingCharacters(in: .whitespaces)
        let nick = self.nick_txt.text?.trimmingCharacters(in: .whitespaces)
        let pass = self.pass_txt.text
        let repass = self.repass_txt.text
        if (!(id == "" || nick == "" || pass == "" || repass == "")){
            if (self.chkId! == true) {
                if(self.chkNick! == true){
                    if(pass == repass){
                        if(TextValidation.init().isValidPassword(self.repass_txt.text)){
                            let path = HttpReqPath.JoinReq
                            let parameters : [ String : String] = [
                                "loggedincase" : LoggedInCase.normal.description,
                                "id" : id!,
                                "password" : pass!,
                                "nick" : nick!
                            ]
                            self.httpRequest?.connection(path, reqParameter: parameters)
                            
                        }else{
                            
                            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_pass_inval)
                        }
                    }else{
                        
                        ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_pass_match)
                    }
                    
                }else{
                    
                    ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_chk)
                }
            }else{

                ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_id_chk)
            }
        }else{
            
            ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_trim)
        }
        
    }
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! String
        if(reqPath == HttpReqPath.JoinIdOverlap){
            if data == "duplicate"{
                self.chkId = false
                
                 ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_id_dupl)
            }else {
                self.chkId = true

                 ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_id_not_dupl)
            }
        }else if(reqPath == HttpReqPath.JoinNickOverlap){
            if data == "duplicate"{
                self.chkNick = false

                 ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_dupl)
            }else {
                self.chkNick = true
                
                 ActionDisplay.init(uvc: self).displayMyAlertMessage(msg_nick_not_dupl)
            }
        }else if(reqPath == HttpReqPath.JoinReq){
             ActionDisplay.init(uvc: self).displayMyAlertMessageActionFromUvc(msg_succ, action: CommonFunction.dismiss)
        }
    }

    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
}

