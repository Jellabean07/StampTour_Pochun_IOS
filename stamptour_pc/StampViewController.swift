//
//  StampViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 6..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit
import CoreLocation


class StampViewController : UIViewController,UITabBarControllerDelegate,  UITableViewDelegate, UITableViewDataSource, HttpResponse , LocationProtocol, LocationDetect, StampSeal{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var introMsg: UILabel!
    @IBOutlet var stampCnt: UILabel!
    @IBOutlet var stampTotal: UILabel!
 
    let TAG : String = "StampViewController"
    var httpRequest : HttpRequestToServer?
    
    var calcDist : CalculateDistance?
    var currentLocation : CurrentLocation?
    
    var contents : [ContentsVO]? = [ContentsVO]()
    var stamps : [StampVO]? = [StampVO]()
    var towns : [TownVO]? = [TownVO]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboardWhenTappedAround()
        self.calcDist = CalculateDistance.init(delegate: self)
        self.currentLocation = CurrentLocation()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        setContentsData()
        setRequest()
        self.tableView.allowsSelection = true
        StampOverlay.delegate = self
        setLocationDelegateTarget()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setLocationDelegateTarget()
        self.tableView.reloadData()
    }
    @IBAction func shared(_ sender: Any) {
    }
    
    func setLocationDelegateTarget(){
        let tbvc = self.tabBarController as! MainViewController
        tbvc.setDelegate(delegate: self)
    }
    
    func setRequest(){
        self.reqCurrentStamp()
        self.reqStamp()
    }
    
    func reqCurrentStamp(){
        let path = HttpReqPath.UserCurrentStamp
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken()
        ]
        
        self.httpRequest?.connection(path, reqParameter: parameters)

    }
    
    func reqStamp(){
        let path = HttpReqPath.StampListReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken()
        ]
        
        self.httpRequest?.connection(path, reqParameter: parameters)
    }
    
    func reqStampSeal(town_code : String, latitude : String, longitude : String){
        let path = HttpReqPath.StampSealReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken(),
            "town_code" : town_code,
            "latitude" : latitude,
            "longitude" : longitude
        ]
        
        self.httpRequest?.connection(path, reqParameter: parameters)
        
    }
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        if(reqPath == HttpReqPath.StampListReq){
            let data = resData["resultData"] as! NSArray
            self.tableView.rowHeight = 80
           // var mvo : StampVO
            self.stamps?.removeAll()
            for row in data{
                var obj = row as! NSDictionary
                
                let mvo = StampVO()
                
                mvo.town_code = obj.object(forKey: "TOWN_CODE") as! Int
                mvo.latitud = obj.object(forKey: "latitud") as! String
                mvo.longitude = obj.object(forKey: "longitude") as! String
                mvo.region_code = obj.object(forKey: "region_code") as! Int
                mvo.valid_range = obj.object(forKey: "valid_range") as! Int
                mvo.nick = obj.object(forKey: "Nick") as! String
                mvo.checktime = obj.object(forKey: "CheckTime") as! String
                mvo.region = obj.object(forKey: "region") as! String
                mvo.rank_no = obj.object(forKey: "rank_no") as! Int
                mvo.active = false
                //NSLog(TAG,"\(mvo)")
                self.stamps?.append(mvo)
            }
            for row in self.stamps!{
                print("\(TAG) : town_code : \(row.town_code!)")
            }
            
            dataMerge()
            StampOverlay.isOverlay = false
            tableView.reloadData()
        }else if(reqPath == HttpReqPath.StampSealReq){
            print("\(TAG) : Success Seal !!!")
            self.setRequest()
        }else if(reqPath == HttpReqPath.UserCurrentStamp){
           
            let data = resData["resultData"] as! NSDictionary
            let next_stamp_count = data["next_stamp_count"] as! Int
            let stamp_count = data["stamp_count"] as! Int
            let grade = data["grade"] as! String
            let nick = data["nick"] as! String
            
            
            print("\(TAG) : next_stamp_count :\(next_stamp_count)")
            print("\(TAG) : stamp_count :\(stamp_count)")
            print("\(TAG) : grade :\(grade)")
            print("\(TAG) : nick :\(nick)")
            
            self.stampCnt.text = String(stamp_count)
            self.stampTotal.text = String(next_stamp_count)
            self.introMsg.text = "\(nick)님은 \(grade) 등급입니다"
//            "next_stamp_count": 3,
//            "stamp_count": 2,
//            "grade": "초급자",
//            "nick": "김지운"

        }else{
            print("\(TAG) : nothing")
        }
    
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        StampOverlay.isOverlay = false
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
    func setContentsData(){
        if let contents : [ContentsVO] = StampDefaultManager.init().getTownList(){
            self.contents = contents
            print("\(TAG) : Success Receive Cotnent Data")
        }
        //dataMerge()
    }
    
    func dataMerge(){
        self.towns = ContentsManager.init(uvc: self).mergeVO(contents: self.contents!, stamps: self.stamps!)
//        for row in self.towns!{
//            print("\(TAG) : region : \(row.region)")
//        }
        //self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.towns!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.towns![(indexPath as NSIndexPath).row];
        var active = false
        let NormalCell = tableView.dequeueReusableCell(withIdentifier: "NormalCell") as! NormalCell
        let ActiveCell = tableView.dequeueReusableCell(withIdentifier: "ActiveCell") as! ActiveCell
        let CompleteCell = tableView.dequeueReusableCell(withIdentifier: "CompleteCell") as! CompleteCell
        
        var distance : String
        if (currentLocation?.state)!{
            let dist = calcDist!.distance(lat1: Double((row.latitude))!, lon1: Double((row.longitude))!, lat2: Double((currentLocation?.latitude)!), lon2: Double((currentLocation?.longitude)!), unit: "K")
            //distance = "\(String(dist)) km"
            
            let distK = Int(dist)
            let distM = (dist - Double(distK)) * 1000
            
            distance = "\(distK)Km \(Int(distM))M"
            //print("\(TAG) : \(distance)")
            let range : Int = (row.range)
            if(dist * 1000 <= Double(range)){
               // active = true
            //버튼활성화처리
            }
        }else{
            distance = "Not Find"
        }
        
        
        
        if(IsStampSealed(nick: row.nick, checktime: row.checktime)){
            // complete
            CompleteCell.vil_thumbnail.image = row.images[0].circle
            CompleteCell.vil_name.text = row.title
            CompleteCell.vil_region.text = row.region
            CompleteCell.vil_distance.text = "\(distance)"
            CompleteCell.vil_count.text = "\(row.stampCount)"
            CompleteCell.vil_date.text = row.checktime
            return CompleteCell
            
        }else{
            if(active){ // distanse active
                // active
                ActiveCell.vil_thumbnail.image = row.images[0].circle
                ActiveCell.vil_name.text = row.title
                ActiveCell.vil_region.text = row.region
               
                return ActiveCell
            }else{
                // normal
                
                NormalCell.vil_thumbnail.image = row.images[0].circle
                NormalCell.vil_name.text = row.title
                NormalCell.vil_region.text = "\(row.region)"
                NormalCell.vil_distance.text = "\(distance)"
                return NormalCell
            }
        }
        

    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let row = self.stamps[(indexPath as NSIndexPath).row];
        //자세히보기 갈부분
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let row = self.towns![(indexPath as NSIndexPath).row];
        viewController.townVO = row
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)

    }
    
    func IsStampSealed(nick : String, checktime : String) -> Bool{
        return (nick != "") && (checktime != "")
    }
    
    
    func LocationSuccessReceive(locations : [CLLocation], latitude : Double, longitude : Double){
        print("\(TAG) : LocationSuccessReceive")
        currentLocation?.latitude = latitude
        currentLocation?.longitude = longitude
        currentLocation?.state = true
        
        
        self.calcDist!.detectDistance(towns: self.towns!, lat: latitude, long: longitude)
        self.tableView.reloadData()
    }
    func LocationFailureReceive(didFailWithError error: Error ){
        currentLocation?.state = false
        print("\(TAG) : LocationFailureReceive")
    }
    
    func ActivatedStampEvent(townVO : TownVO, dist : Double, lat : Double, long : Double){
        print("\(TAG) : ActivatedStampEvent : \(townVO.title)")
        if !StampOverlay.isOverlay{
            StampOverlay.town_code = String(townVO.code)
            StampOverlay.latitude = String(lat)
            StampOverlay.longitude = String(long)
            StampOverlay.show()
        }
    }

    func DeactivatedStampEvent(){
        print("\(TAG) : DeactivatedStampEvent")
        if StampOverlay.isOverlay{
            StampOverlay.isOverlay = false
            StampOverlay.hide()
        }
    }
    
    func Seal(_ town_code : String, latitude : String, longitude : String){
         print("\(TAG) : SealStampEvent")
        self.reqStampSeal(town_code: town_code , latitude: latitude, longitude: longitude)
    }
    
}
