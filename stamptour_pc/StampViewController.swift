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
    
    let dist_msg = NSLocalizedString("main_stamp_sort_by_distance", comment: "거리순")
    let name_msg = NSLocalizedString("main_stamp_sort_by_name", comment: "이름순")
    let region_msg = NSLocalizedString("main_stamp_sort_by_region", comment: "권역순")
    let title_msg = NSLocalizedString("main_stamp_sort_title", comment: "정렬")
    let subtitle_msg = NSLocalizedString("main_stamp_sort_subtitle", comment: "원하는 정렬 방법을 선택하세요")
    let intro_part_1 = NSLocalizedString("main_stamp_user_intro_part_1", comment: "님은")
    let intro_part_2 = NSLocalizedString("main_stamp_user_intro_part_2", comment: "등급입니다")
    let share_not_msg = NSLocalizedString("main_stamp_share_not_social_login", comment: "소셜 로그인을 통해서만 가능합니다")
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var introMsg: UILabel!
    @IBOutlet var stampCnt: UILabel!
    @IBOutlet var stampTotal: UILabel!
    @IBOutlet var naviTitle: UINavigationItem!
 
    let TAG : String = "StampViewController"
    var httpRequest : HttpRequestToServer?
    
    var calcDist : CalculateDistance?
    var currentLocation : CurrentLocation?
    
    var contents : [ContentsVO]? = [ContentsVO]()
    var stamps : [StampVO]? = [StampVO]()
    var towns : [TownVO]? = [TownVO]()
    
    var sortedName : String? = NSLocalizedString("main_stamp_sort_by_standard", comment: "기본")
    
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
        doWork() // 먼저 실행
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(StampViewController.doWork), userInfo: nil, repeats: true)
        
        StampGuideOverlay.show()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(StampViewController.guideExit), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        setLocationDelegateTarget()
//        self.towns =  StampDefaultManager.init().getTowns()
//        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLocationDelegateTarget()
        self.towns =  StampDefaultManager.init().getTowns()
        self.tableView.reloadData()
    }
    
    
    @IBAction func goToHide(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HideViewController") as! HideViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)
    }
    
    @IBAction func sort(_ sender: Any) {
        
        var ActionCodesVO = [ActionCodeVO]()
       
        ActionCodesVO.append(ActionCodeVO.init(title: dist_msg, code : 0, action: sortTowns))
        ActionCodesVO.append(ActionCodeVO.init(title: name_msg, code : 1, action: sortTowns))
        ActionCodesVO.append(ActionCodeVO.init(title: region_msg, code : 2, action: sortTowns))
        
        ActionDisplay.init(uvc: self).showActionSheetCodeAction(title_msg, userMessege: subtitle_msg, actionList: ActionCodesVO)
        
    }
    
    @IBAction func shared(_ sender: Any) {
        let loggedCase = UserDefaultManager.init().getIsLoggedCase()
        switch loggedCase {
        case LoggedInCase.fbLogin.hashValue:
            FBManager.init(uvc: self).share()
            break
        case LoggedInCase.kakaoLogin.hashValue:
            KOManager.init(uvc: self).share()
            break
        default:
            ActionDisplay.init(uvc: self).displayMyAlertMessage(share_not_msg)
            break
        }
       
    }
    
    func sortTowns(_ title : String , _ sortedCode : Int){
        switch sortedCode{
        case 0:
            self.towns = StampSort.shared.sortByDistance(towns: self.towns!)
            
            
            break
        case 1:
            self.towns = StampSort.shared.sortByName(towns: self.towns!)
            break
        case 2:
            self.towns = StampSort.shared.sortByRegion(towns: self.towns!)
        default:
            self.towns = StampSort.shared.sortByDistance(towns: self.towns!)
            break
        }
        self.sortedName = title
        self.naviTitle.title = "\(self.sortedName!) \(self.towns!.count)"
        self.tableView.reloadData()
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
                mvo.region = ContentsManager.init(uvc: self).getRegionName(obj,languageCode: AppInfomation.localizeCode!)
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
            
           
            self.introMsg.text = "\(nick)\(intro_part_1) \(grade) \(intro_part_2)"
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
        hideItem()
    }
    
    func hideItem(){
        let hiddenCodes = StampDefaultManager.init().getHideItem()
        for code in hiddenCodes{
            for (index, row) in  self.towns!.enumerated() {
                if row.code == code {
                    self.towns![index].hidden = true
                    print("\(TAG) : hiddin data : \(index) , code : \(row.code)")
                    break
                    
                }
            }
        }
        setStoreTownVO()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.naviTitle.title = "\(self.sortedName!) \(self.towns!.count)"
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
           // let dist = calcDist!.distance(lat1: Double((row.latitude))!, lon1: Double((row.longitude))!, lat2: Double((currentLocation?.latitude)!), lon2: Double((currentLocation?.longitude)!), unit: "K")
            //distance = "\(String(dist)) km"
            let dist = row.distance
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
                if row.hidden {
                    //NormalCell.isHidden = true
                }
                NormalCell.vil_thumbnail.image = row.images[0].circle
                NormalCell.vil_name.text = row.title
                NormalCell.vil_region.text = "\(row.region)"
                NormalCell.vil_distance.text = "\(distance)"
                return NormalCell
            }
        }
        

    
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let hide = UITableViewRowAction(style: .normal, title: "숨김") { action, index in
            print("\(self.TAG) : hide button tapped : \(index)")
            self.hide(index)
        }
        hide.backgroundColor = UIColor.red
        
        
        return [hide]
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let row = self.stamps[(indexPath as NSIndexPath).row];
        //자세히보기 갈부분
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let row = self.towns![(indexPath as NSIndexPath).row];
        viewController.townVO = row
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated:true, completion: nil)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.towns![(indexPath as NSIndexPath).row];
        var rowHeight:CGFloat = 0.0

        if(row.hidden){
            rowHeight = 0.0
        }else{
            //rowHeight = UITableViewAutomaticDimension
            rowHeight = 80.0    //or whatever you like
        }
                
        return rowHeight
    }

    
    
    func IsStampSealed(nick : String, checktime : String) -> Bool{
        return (nick != "") && (checktime != "")
    }
    
    
    func LocationSuccessReceive(locations : [CLLocation], latitude : Double, longitude : Double){
        print("\(TAG) : LocationSuccessReceive")
        currentLocation?.latitude = latitude
        currentLocation?.longitude = longitude
        currentLocation?.state = true
        
        setDistance(locations)
        self.calcDist!.detectDistance(towns: self.towns!, lat: latitude, long: longitude)
        
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
    
    func hide(_ index : IndexPath){
        print("\(self.TAG) : hide button tapped + \(index)")
        let row = self.towns![(index as NSIndexPath).row];
        StampDefaultManager.init().setHideItem(townCode: row.code)
        let hide = StampDefaultManager.init().getHideItem()
        hideItem()
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
        self.tableView.endUpdates()
        
    }
    
    func setStoreTownVO(){
        StampDefaultManager.init().setTowns(towns: self.towns!)
        if let data : [TownVO] = StampDefaultManager.init().getTowns(){
            for row in data {
                print("\(row.title)")
            }
        }
    }
    
    func setDistance(_ locations : [CLLocation]){
        let location = locations.last
        for (index,row) in self.towns!.enumerated(){
            let dist = calcDist!.distance(lat1: Double((row.latitude))!, lon1: Double((row.longitude))!, lat2: Double((location?.coordinate.latitude)!), lon2: Double((location?.coordinate.longitude)!), unit: "K")
            
            self.towns![index].distance = dist
        }
    }
    
    func doWork(){
        self.tableView.reloadData()
    }
    
    func guideExit(){
        StampGuideOverlay.hide()
    }
}
