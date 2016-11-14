//
//  LocalizationManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 13..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class LocalizationManager {

    class var shared: LocalizationManager {
        struct Static {
            static let instance: LocalizationManager = LocalizationManager()
        }
        return Static.instance
    }
    
    func getConvertContentsLanguageCode(code : String) -> String{
        if (code == "ko"){
            return "kr"
        }else if (code == "en"){
            return "eng"
        }else{
            return "kr"
        }
    }
    
    func getLanguageCode() -> String{
        let langStr = Locale.current.languageCode
        return langStr!
    }
}
