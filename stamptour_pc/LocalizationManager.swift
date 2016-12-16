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
            if(isLanguageCodeEmpty(LanguageInCase.eng.hashValue)){
                return "eng"
            }else{
                return "kr"
            }
        }else if (code == "ja"){
            if(isLanguageCodeEmpty(LanguageInCase.jan.hashValue)){
                return "jp"
            }else{
                return "kr"
            }
        }else if (code == "zh"){
            if(isLanguageCodeEmpty(LanguageInCase.chi.hashValue)){
                return "ch"
            }else{
                return "kr"
            }
        }else{
            return "kr"
        }
    }
    
    func isLanguageCodeEmpty(_ languageCode : Int) -> Bool{
        for code in AppInfomation.surpportLng!{
            if code == languageCode{
                return true
            }
        }
        return false
    }
    
    func getLanguageCode() -> String{
        let langStr = Locale.current.languageCode
        return langStr!
    }
    
    func getLanguageCodeInt() -> Int{
        let code = Locale.current.languageCode
        if (code == "ko"){
            return LanguageInCase.kor.hashValue
        }else if (code == "en"){
            return LanguageInCase.eng.hashValue
        }else if (code == "ja"){
           return LanguageInCase.jan.hashValue
        }else if (code == "zh"){
           return LanguageInCase.chi.hashValue
        }else{
            return LanguageInCase.kor.hashValue
        }
    }
}
