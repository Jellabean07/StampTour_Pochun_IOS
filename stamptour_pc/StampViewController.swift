//
//  StampViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 6..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit

class StampViewController : UIViewController , UITableViewDelegate, UITableViewDataSource, HttpResponse{
    
    let TAG : String = "StampViewController"
    var httpRequest : HttpRequestToServer?
    var stamps = Array<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
    }
    
    func firstData(){
//        
//        nick : 로그인 성공시 받은 nick
//        accesstoken : 로그인 성공시 받은  accesstoken
//        http://hyosang.kr/295   지역코드 및 언어코드 정리링크
//        다국어는 콘텐츠 리소스에서

        let path = HttpReqPath.LoginReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken(),
        ]
        
        self.httpRequest?.connection(path, reqParameter: parameters)
    }
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.stamps[(indexPath as NSIndexPath).row];
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell") as! NormalCell
        cell.vil_name.text = ""
        //cell.vil_thumbnail = ""
        cell.vil_region.text = ""
        cell.vil_distance.text = ""
        
    
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
