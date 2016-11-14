//
//  StampVO.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 10. 27..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class ContentsVO : NSObject, NSCoding{
    
    var no : String
    var title : String
    var subtitle : String
    var region : String
    var latitude : String
    var longitude : String
    var range : String
    var intro : String
    var imgStr : [String]
    
    
    init(no : String, title : String, subtitle : String, region : String, latitude : String, longitude : String, range : String, intro : String, imgStr : [String]) {
        self.no = no
        self.title = title
        self.subtitle = subtitle
        self.region = region
        self.latitude = latitude
        self.longitude = longitude
        self.range = range
        self.intro = intro
        self.imgStr = imgStr
    }
    
    
    required convenience init(coder decoder: NSCoder) {
        let no = decoder.decodeObject(forKey: "no") as! String
        let title = decoder.decodeObject(forKey: "title") as! String
        let subtitle = decoder.decodeObject(forKey: "subtitle") as! String
        let region = decoder.decodeObject(forKey: "region") as! String
        let latitude = decoder.decodeObject(forKey: "latitude") as! String
        let longitude = decoder.decodeObject(forKey: "longitude") as! String
        let range = decoder.decodeObject(forKey: "range") as! String
        let intro = decoder.decodeObject(forKey: "intro") as! String
        let imgStr = decoder.decodeObject(forKey : "imgStr") as! [String]
        
        self.init(
            no: no,
            title: title,
            subtitle: subtitle,
            region: region,
            latitude: latitude,
            longitude: longitude,
            range: range,
            intro: intro,
            imgStr: imgStr
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.no, forKey: "no")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.subtitle, forKey: "subtitle")
        coder.encode(self.region, forKey: "region")
        coder.encode(self.latitude, forKey: "latitude")
        coder.encode(self.longitude, forKey: "longitude")
        coder.encode(self.range, forKey: "range")
        coder.encode(self.intro, forKey: "intro")
        coder.encode(self.imgStr, forKey: "imgStr")
    }
}

class StampVO {

    init() {

    }
    
  
    
    var town_code : Int?
    var latitud : String?
    var longitude : String?
    var region_code : Int?
    var valid_range : Int?
    var nick : String?
    var checktime : String?
    var region : String?
    var rank_no : Int?
    var distance : String?
    var active : Bool?
    
  
}


class TownVO{
    
    //var contents : [ContentsVO]?
    //var stamps : [StampVO]?
    
    var code : Int //마을번호
    var regionCode : Int //권역코드
    var stampCount : Int = 0//몇번째 스탬프
    var title : String  //마을이름
    var subtitle : String //부제목
    var region : String //권역
    var latitude : String //위도
    var longitude : String //경도
    var range : Int //반경
    var intro : String //마을소개
    var nick : String = ""
    var checktime : String = ""
    var images : [UIImage] //마을 이미지
    
    init(code : Int, regionCode : Int, stampCount : Int, title : String, subtitle : String, region : String, latitude : String, longitude : String, range : Int, intro : String, nick : String, checktime : String, images : [UIImage] ){
        self.code = code
        self.regionCode = regionCode
        self.stampCount = stampCount
        self.title = title
        self.subtitle = subtitle
        self.region = region
        self.latitude = latitude
        self.longitude = longitude
        self.range = range
        self.intro = intro
        self.nick = nick
        self.checktime = checktime
        self.images = images
    }
    
    
    

//    
//    func getDirectoryPath() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let documentsDirectory = paths[0].appendingPathComponent("contents", isDirectory: true).appendingPathComponent("contents", isDirectory: true)
//        return documentsDirectory
//    }
    
}
