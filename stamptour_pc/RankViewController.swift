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
    var RankList : Array = Array<RankVO>()
    
    
    @IBOutlet var msg_lab: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let vo = RankVO.init();
        vo.no = 100
        vo.nick = "홍길동"
        vo.cnt = 20
        RankList.append(vo)
        RankList.append(vo)
        RankList.append(vo)
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
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
    
    }


    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
}
