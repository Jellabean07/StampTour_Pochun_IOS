//
//  RankViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class RankViewController : UIViewController , UITableViewDelegate, UITableViewDataSource, HttpResponse{
    
    let TAG : String = "RankViewController"
    var httpRequest : HttpRequestToServer?
    var RankList : [RankVO] = [RankVO]()
    var pageNo : Int?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var msg_lab: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.pageNo = 0
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        self.reqRank()
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
        cell.nick.text = row.nick!
        cell.cnt.text = "찍은 스탬프 \(row.cnt!)개"
        
        
        return cell;
    }
    //item tapped event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //not select
    }


    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
        
        let myrank = data["myrank"] as! NSDictionary
        let rank = myrank["rank"] as! Int
        let nick = myrank["nick"] as! String
        let stamp_count = myrank["stamp_count"] as! Int
        let total = myrank["total"] as! Int
        
        
         print("\(TAG) : rank : \(rank)")
        print("\(TAG) : nick : \(nick)")
        print("\(TAG) : total : \(total)")
        
        self.msg_lab.text = "\(nick)님은 \(total)명 중에 \(rank)위 입니다 "
        
        let ranklist = data["ranklist"] as! NSArray
        for row in ranklist{
            
            let obj = row as! NSDictionary
            
            let mvo = RankVO()
            
            mvo.nick = obj["nick"] as! String
            mvo.no = obj["rank"] as! Int
            mvo.cnt = obj["stamp_count"] as! Int
            
            print("\(TAG) : nick : \(mvo.nick)")
             print("\(TAG) : no : \(mvo.no)")
             print("\(TAG) : cnt : \(mvo.cnt)")
            
            RankList.append(mvo)
        }
        
        self.tableView.reloadData()

    }
}
