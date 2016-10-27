//
//  LanguageInCase.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 29..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

enum LanguageInCase {
    case kor
    case jan
    case chi
    case eng
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
            case .kor: return "KOR";
            case .jan: return "JAN";
            case .chi: return "CHI";
            case .eng: return "ENG";
        }
    }
}
