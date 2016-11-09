//
//  StampVO.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 10. 27..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class ContentsVO : NSObject, NSCoding{
    
    var no : String
    var title : String
    var subtitle : String
    var region : String
    var latitude : String
    var longitude : String
    var range : String
    var intro : String
    
    
    init(no : String, title : String, subtitle : String, region : String, latitude : String, longitude : String, range : String, intro : String) {
        self.no = no
        self.title = title
        self.subtitle = subtitle
        self.region = region
        self.latitude = latitude
        self.longitude = longitude
        self.range = range
        self.intro = intro
    }
    
    
    required convenience init?(coder decoder: NSCoder) {
        guard let no = decoder.decodeObject(forKey: "no") as? String,
            let title = decoder.decodeObject(forKey: "title") as? String,
            let subtitle = decoder.decodeObject(forKey: "subtitle") as? String,
            let region = decoder.decodeObject(forKey: "region") as? String,
            let latitude = decoder.decodeObject(forKey: "latitude") as? String,
            let longitude = decoder.decodeObject(forKey: "logitude") as? String,
            let range = decoder.decodeObject(forKey: "range") as? String,
            let intro = decoder.decodeObject(forKey: "intro") as? String
            else { return nil }
        
        self.init(
            no: no,
            title: title,
            subtitle: subtitle,
            region: region,
            latitude: latitude,
            longitude: longitude,
            range: range,
            intro: intro
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
