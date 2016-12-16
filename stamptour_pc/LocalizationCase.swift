//
//  LocalizationCase.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 12. 16..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
enum LocalizationCase {
    case kor
    case jan
    case chi
    case eng
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .kor: return "kr";
        case .jan: return "jn";
        case .chi: return "cn";
        case .eng: return "en";
        }
    }
}
