//
//  LoggedInCase.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 25..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

enum LoggedInCase {
    case fbLogin
    case kakaoLogin
    case normal
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .fbLogin: return "FBLogin";
        case .kakaoLogin: return "KAKAOLogin";
        case .normal: return "NORMAL";
        }
    }
}
