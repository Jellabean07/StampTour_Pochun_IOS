//
//  ContentsManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 2..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class ContentsManager : HttpResponse{
    
    let TAG = "ContentsManager"
    
    init() {
        
    }
    
    func versionCheck(){
        
        let path = HttpReqPath.LoginReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken(),
            "lastversion" : String(AppDefaultManager.init().getVersion()),
            "lastsize" :String(AppDefaultManager.init().getSize())
        ]
        //        nick : 유저 닉네임
        //        accesstoken : 로그인성공시 받은 엑세스토큰
        //        lastversion : 현재 클라이언트 콘텐츠 버전(처음일시 0 보내면 됨)
        //        lastsize : 현재 클라이언트 콘텐츠 사이즈(처음일시 0 보내면 됨)
        
    }

    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
        let version = data["Version"] as! Int
        let size = data["Size"] as! Int
        let uploadtime = data["UploadTime"] as! String
        
        if((version == -1) && (size == -1)){
            
        }else{
            let appDefualt = AppDefaultManager.init()
            appDefualt.setSize(size)
            appDefualt.setVersion(version)
            appDefualt.setUploadtime(uploadtime)
            //download
        }
    }
}
