//
//  GiftManageViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 3..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class GiftManageViewController : UIViewController ,UITableViewDelegate, UITableViewDataSource,GiftCellDelegate,GiftSendDelegate,HttpResponse{
    
    let msg_complete = NSLocalizedString("gift_manage_complete", comment: "선물신청 완료")
    let msg_press = NSLocalizedString("gift_manage_press_send", comment: "눌러서 선물을 신청하세요")
    let msg_remain = NSLocalizedString("gift_manage_remain", comment: "선물 신청까지")
    
    let TAG : String = "GiftManageViewController"
    var httpRequest : HttpRequestToServer?
    @IBOutlet var tableView: UITableView!
    var allGradeList = Array<allGradeVO>()
    var agoGiftList = Array<agoGiftVO>()
    var mycountVO = MyCountVO.init()
    var sendGrade: String?
    var sendStampCount:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        let parameters : [ String : String] = [
            "accesstoken" : accesstoken,
            "nick" : nick
        ]
        self.httpRequest?.connection(HttpReqPath.UserCurrentGift, reqParameter: parameters)
    }
    
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        if(reqPath == HttpReqPath.UserCurrentGift){
            if(resCode == "00" && resMsg == "SUCCESS"){
                let data = resData["resultData"] as! NSDictionary
                let myCount = data["myCount"] as! NSDictionary
                let allGrade = data["allGrade"] as! NSArray
                let agoGift = data["agoGift"] as! NSArray
                
                
                mycountVO.nick = myCount["nick"] as? String
                mycountVO.stamp_count = myCount["stamp_count"] as? Int
                for row in allGrade{
                    let obj = row as! NSDictionary
                    
                    allGradeList.append(allGradeVO.init(grade: obj["grade"] as! String, stamp_count: obj["stamp_count"] as! Int))
                }
                for row in agoGift{
                    let obj = row as! NSDictionary
                    
                    agoGiftList.append(agoGiftVO.init(grade: obj["grade"] as! String, check_time: obj["CheckTime"] as! String))
                }
                
//                let agoGift = data["agoGift"] as! NSDictionary
//                let allGrade = data["allGrade"] as! NSDictionary
                NSLog(TAG, data);
                NSLog(TAG,myCount)
                NSLog(mycountVO.nick!,mycountVO.stamp_count!.description)
                NSLog(allGradeList.description, allGradeList.description)
                NSLog(agoGiftList.description, agoGiftList.description)
                tableView.reloadData()
            }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGradeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.allGradeList[(indexPath as NSIndexPath).row];
        let giftCell = tableView.dequeueReusableCell(withIdentifier: "GiftCell") as! GiftCell
        let agoGiftCount = self.agoGiftList.count
        if giftCell.buttonDelegate == nil {
            giftCell.buttonDelegate = self
        }
        if((mycountVO.stamp_count?.hashValue)!>=row.stamp_count!){
            NSLog("StampCount is up", "comein")
            var flag = true
            if(agoGiftList.count != 0){
                NSLog("comein?", "comein")
                for agoGiftData in agoGiftList{
                    if(agoGiftData.grade == row.grade){
                        giftCell.giftGrade.text = row.grade
                        giftCell.giftCount.text = msg_complete
                        giftCell.giftSendBtn.isUserInteractionEnabled = false
                        giftCell.giftSendBtn.isHidden = true
                        flag = false
                        return giftCell
                    }
//                    giftCell.giftGrade.text = row.grade
//                    giftCell.giftCount.text = "눌러서 선물을 신청하세요"
//                    giftCell.giftSendBtn.tag = indexPath.row
//                    return giftCell
                }
                if(flag){
                    giftCell.giftGrade.text = row.grade
                    giftCell.giftCount.text = msg_press
                    giftCell.giftSendBtn.tag = indexPath.row
                    return giftCell
                }
            }else{
                giftCell.giftGrade.text = row.grade
                giftCell.giftCount.text = msg_press
                giftCell.giftSendBtn.tag = indexPath.row
                return giftCell
            }
        }else{
            let count = row.stamp_count!-mycountVO.stamp_count!
            giftCell.giftGrade.text = row.grade
            giftCell.giftCount.text = "\(msg_remain) \(count.description)"
            giftCell.giftSendBtn.isUserInteractionEnabled = false
            giftCell.giftSendBtn.isHidden = true
        }
        NSLog(row.grade!, row.grade!)
        return giftCell
    }
    func Tapped(event: GiftRequestEvent) {
        NSLog("GiftRequestEventCall")
        if event.status == false {
            return
        }
        let nick = UserDefaultManager.init().getUserNick()
        let accesstoken = UserDefaultManager.init().getUserAccessToken()
        let parameters : [ String : String] = [
            "accesstoken" : accesstoken,
            "nick" : nick
        ]
        allGradeList.removeAll()
        agoGiftList.removeAll()
        self.httpRequest?.connection(HttpReqPath.UserCurrentGift, reqParameter: parameters)
    }
    
    func cellTapped(cell: GiftCell) {
        let tapped_row = self.allGradeList[tableView.indexPath(for: cell)!.row];
        self.sendGrade = tapped_row.grade
        self.sendStampCount = tapped_row.stamp_count
        NSLog("TABLE BUTTON TAP : "+tapped_row.grade!)
//        self.performSegue(withIdentifier: "GiftRequestsegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GiftRequestsegue") {
            let giftRequestViewController = (segue.destination as! GiftRequestViewController)
            NSLog(TAG+self.sendGrade!)
            giftRequestViewController.grade = self.sendGrade
            giftRequestViewController.stamp_count = self.sendStampCount
            giftRequestViewController.sourceViewController = self
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let row = self.allGradeList[(indexPath as NSIndexPath).row];
    }
}
