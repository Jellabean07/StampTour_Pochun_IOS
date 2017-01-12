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
        self.httpDownload = HttpDownWithServer.init(TAG: TAG, delegate: self)
        self.uvc = uvc
    }
    
    
    func mergeVO(contents : [ContentsVO], stamps : [StampVO]) -> [TownVO]{
        var towns : [TownVO] = [TownVO]()
        for row in contents{
            for col in stamps{
               // print("\(TAG) : col.town_code : \(col.town_code!)")
               // print("\(TAG) : row.no : \(Int(row.no)!)")
                if Int(row.no)! == col.town_code!{
                   
                    let code = col.town_code!
                    let regionCode = col.region_code!
                    let stampCount = col.rank_no!
                    let title = row.title
                    let subtitle = row.subtitle
                    let region = col.region!
                    let latitude = col.latitud!
                    let longitude = col.longitude!
                    let range = col.valid_range!
                    let intro = row.intro
                    let nick = col.nick!
                    let checktime = col.checktime!
                    var images = [UIImage]()
                    for img in row.imgStr{
                        images.append(FileBrowser.init().getImage(named: img))
                    }
                    let townVO = TownVO(code: code, regionCode: regionCode, stampCount: stampCount, title: title, subtitle: subtitle, region: region, latitude: latitude, longitude: longitude, range: range, intro: intro, nick: nick, checktime: checktime, images: images,hidden: false)
                    towns.append(townVO)
                }
            }
        }
        return towns
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

    func getRegionName(_ obj : NSDictionary, languageCode : Int ) -> String{
        switch languageCode {
        case LanguageInCase.kor.hashValue:
            if LocalizationManager.shared.isLanguageCodeEmpty(languageCode){
                 return obj.object(forKey: "region") as! String
            }else{
                 return obj.object(forKey: "region") as! String
            }
        case LanguageInCase.eng.hashValue:
            if LocalizationManager.shared.isLanguageCodeEmpty(languageCode){
                return obj.object(forKey: "region_en") as! String
            }else{
                return obj.object(forKey: "region") as! String
            }
        case LanguageInCase.jan.hashValue:
            if LocalizationManager.shared.isLanguageCodeEmpty(languageCode){
                return obj.object(forKey: "region_jp") as! String
            }else{
                return obj.object(forKey: "region") as! String
            }
            
        case LanguageInCase.chi.hashValue:
            if LocalizationManager.shared.isLanguageCodeEmpty(languageCode){
                return obj.object(forKey: "region_cn") as! String
            }else{
                return obj.object(forKey: "region") as! String
            }
        default:
            return obj.object(forKey: "region") as! String
        }
    }
    
    func expanding(){
        
     FileBrowser.init().setUnZip(file: "contents.zip")
    }
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
    
        let version = data["Version"] as! Int
        let size = data["Size"] as! Int
        //let uploadtime = data["UploadTime"] as! String
        
        if((version == -1) && (size == -1)){
            print("\(TAG) : Latest version ")
            setLocalizationContent()
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
    
    func setLocalizationContent(){
         let fileBrowser = FileBrowser.init()
        let jsonString = fileBrowser.fileLocalizationReadJson()
        
        fileBrowser.convertJsonArray(text: jsonString)
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        UserDefaultManager.init().loggedOut(uvc: self.uvc!)
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
    func HttpDownResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! NSDictionary
        let fileBrowser = FileBrowser.init()
        fileBrowser.setUnZip(file: "contents.zip")
        
        
       // let langStr = LocalizationManager.shared.getLanguageCode()
        //print("\(TAG) : language code : \(langStr) ")
        
        //let langCode = LocalizationManager.shared.getConvertContentsLanguageCode(code: langStr )
       // let jsonString = fileBrowser.fileLocalizationReadJson()

        //fileBrowser.convertJsonArray(text: jsonString)
        
        setLocalizationContent()
        
        //파일확인 로그
        fileBrowser.updateFiles()
        print(FileBrowser.init().getDocumentsDirectory())
        fileBrowser.currentFiles()
        
        CommonFunction.moveToController(uvc: self.uvc!)
        print("download good")
        print(resCode)
        print(resMsg)
        print(resData)
        
    }
    
    
    
    
    
}
