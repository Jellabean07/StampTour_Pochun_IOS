//
//  StringMsg.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 26..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

class StringMsg{
    
    var Login_Input_request : String?
    
    var HttpResponse_FAIL : String?
    var HttpResponse_CODE_01 : String?
    var HttpResponse_CODE_02 : String?
    var HttpResponse_CODE_03 : String?
    
    init(code : Int){
        switch code {
        case LanguageInCase.kor.hashValue:
            Login_Input_request = "계정정보를 모두 입력해주세요"
            
            HttpResponse_FAIL = "인터넷 연결에 실패하였습니다 \n 다시 시도 해주세요"
            HttpResponse_CODE_01 = "데이터 불충분 또는 유효하지 않는 입력입니다"
            HttpResponse_CODE_02 = "올바른 값은 얻지 못했습니다"
            HttpResponse_CODE_03 = "서버에서 오류가 발생했습니다"
            
            break
        case LanguageInCase.jan.hashValue:
            break
        case LanguageInCase.chi.hashValue:
            break
        case LanguageInCase.eng.hashValue:
            break
        default:
            break
        }
    }
    
    
    
    
    
}
