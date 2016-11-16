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
    case Default, pochun, shinan
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIControlManager.init().colorWithHexString("#ffffff")
        case .pochun:
            return UIControlManager.init().colorWithHexString("#00c3e5")
        case .shinan:
            return UIControlManager.init().colorWithHexString("#00a1e9")
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
        }
    }
}
