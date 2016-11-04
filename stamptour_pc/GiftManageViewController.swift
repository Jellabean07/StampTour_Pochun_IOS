//
//  GiftManageViewController.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 3..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit


class GiftManageViewController : UIViewController , UITableViewDelegate, UITableViewDataSource, HttpResponse{
    
    let TAG : String = "GiftManageViewController"
    var httpRequest : HttpRequestToServer?
    @IBOutlet var tableView: UITableView!
    var allGradeList = Array<allGradeVO>()
    var agoGiftList = Array<agoGiftVO>()
    var mycountVO = MyCountVO.init()
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
    
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
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
        if((mycountVO.stamp_count?.hashValue)!>=row.stamp_count!){
            if(agoGiftList.count != 0){
                if((indexPath as NSIndexPath).row < agoGiftCount){
                    let agoGift = self.agoGiftList[(indexPath as NSIndexPath).row]
                    if(agoGift.grade == row.grade){
                        giftCell.giftGrade.text = row.grade
                        giftCell.giftCount.text = "선물신청 완료"
                        return giftCell
                    }
                }
                giftCell.giftGrade.text = row.grade
                giftCell.giftCount.text = "눌러서 선물을 신청하세요"
                return giftCell
            }else{
                giftCell.giftGrade.text = row.grade
                giftCell.giftCount.text = "눌러서 선물을 신청하세요"
                return giftCell
            }
        }else{
            giftCell.giftGrade.text = row.grade
            giftCell.giftCount.text = "선물받기까지 "+(row.stamp_count?.description)!+"개 남았습니다."
        }
        NSLog(row.grade!, row.grade!)
        return giftCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let row = self.allGradeList[(indexPath as NSIndexPath).row];
    }

}
