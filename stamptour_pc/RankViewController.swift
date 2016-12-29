//
//  RankViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class RankViewController : UIViewController , UITableViewDelegate, UITableViewDataSource, HttpResponse{
    
    let intro_part_1 = NSLocalizedString("ranking_user_intro_part_1", comment: "님은")
    let intro_part_2 = NSLocalizedString("ranking_user_intro_part_2", comment: "명 중에")
    let intro_part_3 = NSLocalizedString("ranking_user_intro_part_3", comment: "위 입니다")
    
    let TAG : String = "RankViewController"
    var httpRequest : HttpRequestToServer?
    var RankList : [RankVO] = [RankVO]()
    var pageNo : Int?
    var isNewDataLoading : Bool?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var msg_lab: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.pageNo = 0
        self.isNewDataLoading = false
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        self.reqRank()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func reqRank(){
        let path = HttpReqPath.rankReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken(),
            "pageno" : String(describing: self.pageNo!)
        ]
        
        self.httpRequest?.connection(path, reqParameter: parameters)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RankList.count
    }
    
    
    func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath)-> UITableViewCell{
        let row = self.RankList[(indexPath as NSIndexPath).row];
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankCell") as! RankCell
        cell.no.text = "\(row.no!)."
        cell.no.textColor = AppInfomation.themeColor
        cell.nick.text = row.nick!
        
        let count_stamp = NSLocalizedString("ranking_count_stamp", comment: "찍은 스탬프")
        cell.cnt.text = "\(count_stamp) \(row.cnt!)"
        
        
        return cell;
    }
    //item tapped event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //not select
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        print("\(TAG) : Bottom Refresh : 시작")
        if scrollView == self.tableView{
             print("\(TAG) : Bottom Refresh : 진입")
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                 print("\(TAG) : Bottom Refresh : 스크롤링바텀")
                if !self.isNewDataLoading!{
                     print("\(TAG) : Bottom Refresh : dataload")
                    self.isNewDataLoading = true
                    self.pageNo! = self.pageNo! + 1
                    self.reqRank()
                }
            }
        }
    }

    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
        
        let myrank = data["myrank"] as! NSDictionary
        let rank = myrank["rank"] as! Int
        let nick = myrank["nick"] as! String
        let stamp_count = myrank["stamp_count"] as! Int
        let total = myrank["total"] as! Int
        
        
//         print("\(TAG) : rank : \(rank)")
//        print("\(TAG) : nick : \(nick)")
//        print("\(TAG) : total : \(total)")
       
        
        if AppInfomation.localizeCode! == LocalizationCase.eng.hashValue {
            self.msg_lab.text = "\(nick)\(intro_part_1) \(rank)\(intro_part_2) \(total)\(intro_part_3) "
        }else if AppInfomation.localizeCode! == LocalizationCase.chi.hashValue {
            self.msg_lab.text = "\(nick)\(intro_part_1) \(rank)\(intro_part_2) \(total)\(intro_part_3) "
        }else{
            self.msg_lab.text = "\(nick)\(intro_part_1) \(total)\(intro_part_2) \(rank)\(intro_part_3) "
        }
        
        
        let ranklist = data["ranklist"] as! NSArray
        
        if ranklist.count == 0 {
            if self.pageNo! > 0 {
                self.pageNo! = self.pageNo! - 1
            }
        }
        
        for row in ranklist{
            
            let obj = row as! NSDictionary
            
            let mvo = RankVO()
            
            mvo.nick = obj["nick"] as! String
            mvo.no = obj["rank"] as! Int
            mvo.cnt = obj["stamp_count"] as! Int
            
//            print("\(TAG) : nick : \(mvo.nick!)")
//             print("\(TAG) : no : \(mvo.no!)")
//             print("\(TAG) : cnt : \(mvo.cnt!)")
            
            RankList.append(mvo)
        }
        
        if (total > RankList.count + 30) {
            self.isNewDataLoading = false
        }
        
        self.tableView.reloadData()

    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
}
