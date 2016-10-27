//
//  Config.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 25..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class Config{
    init(){
       
    }
    
    var HttpHost = "http://stamptour-cli-test.mybluemix.net"
    // 클라이언트 테스트 http://stamptour-cli-test.mybluemix.net
    // 실제 서버 호스트 http://stamptour.mybluemix.ne
    let HttpLoginRequest = "/user/login"
    let JoinRequest = "/user/join"
    let StampRequest = "/town/list"
    
    let MainGreenColor = "#00CCCC"
    let MainRedColor = "#FE3F35"
    let MainBlueColor = "#007AFF"
    let MainBackGroundColor = "#EFEFF4"
    let MainBackGroundColor2 = "#FFFFFF"
    
    let MainLineColor = "#CECED2"
    
    let ListSubTitleFontColor = "#666666"
    let ListSubTitleFontSize = "13.0"
    let ListFontColor = "#000000"
    let ListFontSize = "16.0"
    let ListInputPlaceholderFontColor = "#9A9A9A"
    let ListIntputPlaceholderFontSize = "16.0"
    
    let NaviBackGroundColor = "#F6F6F6"
    let NaviFontColor = "#000000"
    let NaviFontSize = "18.0"
    
    let FacebookHexColor = "#3B5998"
    let KakaotalkHexColor = "#FFF000"
    
}
