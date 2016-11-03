//
//  StampViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 6..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit
import CoreLocation

class StampViewController : UIViewController ,CLLocationManagerDelegate,  UITableViewDelegate, UITableViewDataSource, HttpResponse{
    
    @IBOutlet var tableView: UITableView!
    
    let TAG : String = "StampViewController"
    var httpRequest : HttpRequestToServer?
    var stamps = Array<StampVO>()
    var locationManager = CLLocationManager()
    var currentLocation : CurrentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboardWhenTappedAround()
        self.currentLocation = CurrentLocation()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        self.setLoactionManager()
        self.reqStamp()
         self.tableView.allowsSelection = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.setLoactionManager()
    }
    
    func setLoactionManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            print("start loaction")
        }
        
    }

    
    func reqStamp(){
        let path = HttpReqPath.StampListReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken()
        ]
        
        self.httpRequest?.connection(path, reqParameter: parameters)
    }
    
    func reqStampSeal(town_code : String, latitude : String, logitude : String){
        let path = HttpReqPath.StampSealReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken(),
            "town_code" : town_code,
            "latitude" : latitude,
            "logitude" : logitude
        ]
        
        self.httpRequest?.connection(path, reqParameter: parameters)
        
    }
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        if(reqPath == HttpReqPath.StampListReq){
            let data = resData["resultData"] as! NSArray
            self.tableView.rowHeight = 80
            var mvo : StampVO
            
            for row in data{
                var obj = row as! NSDictionary
                
                mvo = StampVO()
                
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
                // NSLog(TAG,"\(mvo)")
                self.stamps.append(mvo)
            }
            // NSLog(TAG,"\(stamps)")
            
            tableView.reloadData()
        }else if(reqPath == HttpReqPath.StampSealReq){
            
        }else{
            print("\(TAG) : nothing")
        }
    
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stamps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.stamps[(indexPath as NSIndexPath).row];
       
        
        let NormalCell = tableView.dequeueReusableCell(withIdentifier: "NormalCell") as! NormalCell
        let ActiveCell = tableView.dequeueReusableCell(withIdentifier: "ActiveCell") as! ActiveCell
        let CompleteCell = tableView.dequeueReusableCell(withIdentifier: "CompleteCell") as! CompleteCell
        
        var distance : String
        if (currentLocation?.state)!{
            let dist = CalculateDistance().distance(lat1: Double(row.latitud!)!, lon1: Double(row.longitude!)!, lat2: Double((currentLocation?.latitude)!), lon2: Double((currentLocation?.longitude)!), unit: "K")
            distance = String(dist)
            
            print("\(TAG) : \(distance)")
            if(dist * 1000 <= Double(row.valid_range!)){
                row.active =  true
                //버튼활성화처리
            }
        }else{
            distance = "Not Find"
        }
        
        
        
        if(IsStampSealed(nick: row.nick!, checktime: row.checktime!)){
            // complete
            CompleteCell.vil_thumbnail.image = UIImage(named: "img_stamp")
            CompleteCell.vil_name.text = "완료 마을"
            CompleteCell.vil_region.text = row.region!
            CompleteCell.vil_distance.text = "\(distance) km"
            CompleteCell.vil_count.text = "\(row.rank_no!)"
            CompleteCell.vil_date.text = row.checktime!
            return CompleteCell
            
        }else{
            if(row.active)!{ // distanse active
                // active
                ActiveCell.vil_thumbnail.image = UIImage(named: "img_stamp")
                ActiveCell.vil_name.text = "액티브 마을"
                ActiveCell.vil_region.text = row.region!
               
                return ActiveCell
            }else{
                // normal
                
                NormalCell.vil_thumbnail.image = UIImage(named: "img_stamp")
                NormalCell.vil_name.text = "기본 마을"
                NormalCell.vil_region.text = "\(row.region!)"
                NormalCell.vil_distance.text = "\(distance) km"
                return NormalCell
            }
        }
        

        
    
        //stamps[indexPath]
//        "TOWN_CODE": 4,
//        "latitud": "38.0798562",
//        "longitude": "127.2169767",
//        "region_code": 1,
//        "valid_range": 50,
//        "Nick": "김지페",
//        "CheckTime": "2016-10-17 03:46:57",
//        "region": "북구",
//        "rank_no": 2
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(Active){
//            
//        }
       
        
        let row = self.stamps[(indexPath as NSIndexPath).row];
        
      //  reqStampSeal(town_code: String(describing: row.town_code) , latitude: String(describing: currentLocation?.latitude), logitude: String(describing: currentLocation?.longitude))
       
    }
    
    func IsStampSealed(nick : String, checktime : String) -> Bool{
        return (nick != "") && (checktime != "")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last

        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
       
        print("\(TAG) user latitude = \(location!.coordinate.latitude)")
        print("\(TAG) user longitude = \(location!.coordinate.longitude)")
        
        currentLocation?.latitude = Double(location!.coordinate.latitude)
        currentLocation?.longitude = Double(location!.coordinate.longitude)
        currentLocation?.state = true
        self.tableView.reloadData()
        //self.locationManager.stopUpdatingLocation()
    
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocation?.state = false
        print("Error \(error.localizedDescription)")
    }
}
