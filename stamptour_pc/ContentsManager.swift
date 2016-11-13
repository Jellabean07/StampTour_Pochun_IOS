//
//  ContentsManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 2..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit
import Zip


class ContentsManager : HttpResponse, HttpDownResponse{
    
    let TAG = "ContentsManager"
    
    var httpRequest : HttpRequestToServer?
    var httpDownload : HttpDownWithServer?
    var uvc : UIViewController?
    
    init(uvc : UIViewController) {
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate: self)
        self.httpDownload = HttpDownWithServer.init(TAG: TAG, delegate: self ,view : uvc.view)
        self.uvc = uvc
    }
    
    func versionCheck(){
        
        let path = HttpReqPath.VersionCheck
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
        httpRequest?.connection(path, reqParameter: parameters)
    }
    
    func contentsDown(){
        
        let path = HttpReqPath.ContentsReq
        let parameters : [ String : String] = [
            "nick" : UserDefaultManager.init().getUserNick(),
            "accesstoken" : UserDefaultManager.init().getUserAccessToken()
        ]
        //        nick : 유저 닉네임
        //        accesstoken : 로그인성공시 받은 엑세스토큰

        httpDownload?.download(path, reqParameter: parameters)
    }

    
    func expanding(){
        
     FileBrowser.init().setUnZip(file: "contents.zip")
    }
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
    
        let version = data["Version"] as! Int
        let size = data["Size"] as! Int
        //let uploadtime = data["UploadTime"] as! String
        
        if((version == -1) && (size == -1)){
            print("\(TAG) : Latest version ")
            CommonFunction.moveToController(uvc: self.uvc!)
        }else{
            let uploadtime = data["UploadTime"] as! String
            let appDefualt = AppDefaultManager.init()
            appDefualt.setSize(size)
            appDefualt.setVersion(version)
            appDefualt.setUploadtime(uploadtime)
            //download
            contentsDown()
            print("Download Contents")
            
        }
        // contentsDown()
        
    }
    
    func HttpDownResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! NSDictionary
    
        let fileBrowser = FileBrowser.init()
        fileBrowser.setUnZip(file: "contents.zip")
        fileBrowser.updateFiles()
        let jsonString = fileBrowser.readFromDocumentsFile(fileName: "kr.json")
        fileBrowser.convertJsonArray(text: jsonString)
        print(FileBrowser.init().getDocumentsDirectory())
        fileBrowser.currentFiles()
        
        CommonFunction.moveToController(uvc: self.uvc!)
        print("download good")
        print(resCode)
        print(resMsg)
        print(resData)
        
    }
    
    
    
}
