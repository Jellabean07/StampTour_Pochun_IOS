//
//  RegionResValue.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit


enum applySetting{
    case pochun, shinan
}

enum ResRegion {
    case Default, pochun, shinan, gyeongju, gongju
    
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIControlManager.init().colorWithHexString("#ffffff")
        case .pochun:
            return UIControlManager.init().colorWithHexString("#00C3E5") //00BE88 , 00c3e5
        case .shinan:
            return UIControlManager.init().colorWithHexString("#00A1E9")
        case .gyeongju:
            return UIControlManager.init().colorWithHexString("#00CCCC")
        case .gongju:
            return UIControlManager.init().colorWithHexString("#e5a200")
        }
    }
    
    var appName : String { //지역화필요
        switch self {
        case .Default:
            return "스탬프투어"
        case .pochun:
            return "포천스탬프투어"
        case .shinan:
            return "신안스탬프투어"
        case .gyeongju:
            return "뉴경주스탬프투어"
        case .gongju:
            return "공주스탬프투어"
        }
    }
    
    var appHost : String {
        switch self {
        case .Default:
            return "http://stamptourpochondev.mybluemix.net"
        case .pochun:
            return "http://stamptourpochon.mybluemix.net"
        case .shinan:
            return "http://stamptourshinan.mybluemix.net"
        case .gyeongju:
            return "http://stamptourkyoungju.mybluemix.net"
        case .gongju:
            return "http://stamptourgongju.mybluemix.net"
        }
    }
    
    
    var appPakage : String {
        switch self {
        case .Default:
            return "com.thatzit.stamptour.Shinan"
        case .pochun:
            return "com.thatzit.stamptour.PochunStampTour"
        case .shinan:
            return "com.thatzit.stamptour.Shinan"
        case .gyeongju:
            return "com.thatzit.stamptour.Gyeongju"
        case .gongju:
            return "com.thatzit.stamptour.Gongju"
        }
    }
    
    var supportLanguage : [Int] {
        switch self {
        case .Default:
            return [LocalizationCase.kor.hashValue]
        case .pochun:
            return [LocalizationCase.kor.hashValue,LocalizationCase.eng.hashValue]
        case .shinan:
            return [LocalizationCase.kor.hashValue]
        case .gyeongju:
            return [LocalizationCase.kor.hashValue,LocalizationCase.eng.hashValue,LocalizationCase.jan.hashValue,LocalizationCase.chi.hashValue]
        case .gongju:
            return [LocalizationCase.kor.hashValue,LocalizationCase.eng.hashValue,LocalizationCase.jan.hashValue,LocalizationCase.chi.hashValue]
        }
    }
    
    var fbAppKey : String {
        switch self {
        case .Default:
            return "not key"
        case .pochun:
            return "1196868970378253"
        case .shinan:
            return "136732466792572"
        case .gyeongju:
            return "1256362331100459"
        case .gongju:
            return "217422435378299"
        }
    }
    
    var fbAppStoreLink : String {
        switch self {
        case .Default:
            return "https://developers.facebook.com"
        case .pochun:
            return "https://itunes.apple.com/us/app/pocheonseutaempeutueo/id1170904141?mt=8"
        case .shinan:
            return "https://itunes.apple.com/us/app/sin-anseutaempeutueo/id1170914508?mt=8"
        case .gyeongju:
            return "https://itunes.apple.com/app/id1181294752?mt=8"
        case .gongju:
            return "https://itunes.apple.com/app/id1190593570?mt=8"
        }
    }
    
    var koAppKey : String {
        switch self {
        case .Default:
            return "not key"
        case .pochun:
            return "527f0df26e167313b802571444d94111"
        case .shinan:
            return "b3766d4a60aabdf52a60a574ed9a68d3"
        case .gyeongju:
            return "12dca0c65b433896e42b0f8a612f3fc3"
        case .gongju:
            return "c382ee5f3906b73ac72df987bdec71da"
        }
    }
    
    var koAppStoreLink : String {
        switch self {
        case .Default:
            return "https://developers.facebook.com"
        case .pochun:
            return "https://itunes.apple.com/us/app/pocheonseutaempeutueo/id1170904141?mt=8"
        case .shinan:
            return "https://itunes.apple.com/us/app/sin-anseutaempeutueo/id1170914508?mt=8"
        case .gyeongju:
            return "https://itunes.apple.com/app/id1181294752?mt=8"
        case .gongju:
            return "https://itunes.apple.com/app/id1190593570?mt=8"
        }
    }
    
    var appStoryboard : String {
        switch self {
        case .Default:
            return "Main"
        case .pochun:
            return "Pocheon"
        case .shinan:
            return "Shinan"
        case .gyeongju:
            return "Main"
        case .gongju:
            return "Main"
        }
    }
    
    
}
