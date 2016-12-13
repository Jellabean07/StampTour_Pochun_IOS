//
//  SurveyViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 15..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton
class SurveyViewController : UIViewController , UITextViewDelegate,HttpResponse{
    
    let msg_add = NSLocalizedString("survey_additional_msg", comment: "기타 의견을 입력하세요.")
    let msg_success = NSLocalizedString("survey_alert_send_succeess", comment: "설문이 작성 되었습니다")
    let msg_fail_1 = NSLocalizedString("survey_alert_send_fail_01", comment: "설문 작성 중에 오류가 발생했습니다")
    let msg_fail_2 = NSLocalizedString("survey_alert_send_fail_02", comment: "설문 작성 중에 오류가 발생했습니다")
    let msg_fail_3 = NSLocalizedString("survey_alert_send_fail_03", comment: "이미 설문 조사에 참여하셨습니다")
    
    @IBOutlet var textView: UITextView!
    let TAG : String = "GiftManageViewController"
    var httpRequest : HttpRequestToServer?
    var score:Int?
    

    @IBOutlet var score1Radio: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        textView.text = msg_add
        textView.textColor = UIColor.lightGray
        score1Radio.isSelected = true
        score1Radio.indicatorColor = AppInfomation.themeColor!
        score = 1
        
       
        
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = msg_add
            textView.textColor = UIColor.lightGray
        }
    }
    @objc @IBAction fileprivate func logSelectedButton(_ radioButton : DLRadioButton) {
        switch String(format:(radioButton.selected()?.titleLabel?.text)!) {
        case "score1":
            NSLog("111111")
            score = 1
        case "score2":
            NSLog("222222")
            score = 2
        case "score3":
            NSLog("333333")
            score = 3
        case "score4":
            NSLog("444444")
            score = 4
        case "score5":
            NSLog("555555")
            score = 5
        default:
            return
        }
//            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        
    }
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
        if(reqPath == HttpReqPath.SurveyReq){
            ActionDisplay.init(uvc: self).displayMyAlertMessageDismissView(msg_success)
        }
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            ActionDisplay.init(uvc: self).displayMyAlertMessageDismissView(msg_fail_1)
        }else if (resCode == "02"){
            ActionDisplay.init(uvc: self).displayMyAlertMessageDismissView(msg_fail_2)
        }else if (resCode == "03"){
            ActionDisplay.init(uvc: self).displayMyAlertMessageDismissView(msg_fail_3)
        }
    }
    
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    @IBAction func submit(_ sender: AnyObject) {
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        var text = textView.text.description
        if(text == msg_add){
            text = ""
        }
        NSLog(nick)
        NSLog(accesstoken)
        NSLog((score?.description)!)
        NSLog(text)
        let parameters : [ String : String] = [
            "accesstoken" : accesstoken,
            "nick" : nick,
            "survey_point" : (score?.description)!,
            "contents" : text
        ]
        self.httpRequest?.connection(HttpReqPath.SurveyReq, reqParameter: parameters)
    }
    

    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        animateViewMoving(false, moveValue: 200)
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
         animateViewMoving(true, moveValue: 200)
        return true
    }
    
   
    

    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
}
