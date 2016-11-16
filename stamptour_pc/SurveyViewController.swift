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
    
    @IBOutlet var textView: UITextView!
    let TAG : String = "GiftManageViewController"
    var httpRequest : HttpRequestToServer?
    var score:Int?
    @IBOutlet var score1Radio: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        textView.text = "기타 의견을 입력하세요."
        textView.textColor = UIColor.lightGray
        score1Radio.isSelected = true
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
            textView.text = "기타 의견을 입력하세요."
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
            ActionDisplay.init(uvc: self).displayMyAlertMessageDismissView("설문완료")
        }
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
    @IBAction func pop(_ sender: AnyObject) {
        CommonFunction.dismiss(self)
    }
    @IBAction func submit(_ sender: AnyObject) {
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        var text = textView.text.description
        if(text == "기타 의견을 입력하세요."){
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
}
