//
//  RegionInCase.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

enum RegionInCase {
    case pochun
    case shinan

    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .pochun: return "pochun";
        case .shinan: return "shinan";
 
        }
    }
}
