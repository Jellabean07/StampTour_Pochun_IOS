//
//  RegionResValue.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

enum ThemeColor {
    case Default, pochun, shinan
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIControlManager.init().colorWithHexString("#ffffff")
        case .pochun:
            return UIControlManager.init().colorWithHexString("#00c3e5")
        case .shinan:
            return UIControlManager.init().colorWithHexString("#00ale9")
        }
    }
}
