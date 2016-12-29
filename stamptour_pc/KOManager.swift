//
//  KOManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 12. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

class KOManager : HttpResponse{
    
    let TAG : String = "KOManager"
    var httpRequest : HttpRequestToServer?
    var uvc : UIViewController?
    var userId : String = ""
    
    init(uvc : UIViewController) {
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        self.uvc = uvc
    }
    func getReturnState(){
        if let seesion = KOSession.shared(){
            if seesion.isOpen(){
                KOSessionTask.meTask { [weak self] (user, error) -> Void in
                    if error != nil {
                        print("\(self!.TAG) : KOSession getReturnState : requestMe error = \(error)")
                        
                    } else {
                        if let user = user as? KOUser {
                            print("\(self!.TAG) : KOSession Login : requestMe Success: id is = \(user.id!)")
                            let id = String(describing: user.id!)
                            self?.userId = id
                            self!.reqLogin(userId: id)
                        }
                    }
                }
            }else{
                login()
            }
        }
    }
    
    func logout(){
        let session = KOSession.shared()
        if let s = session {
            if s.isOpen(){
                s.close()
            }
        }
    }
    
    func login(){
        let session = KOSession.shared()
        if let s = session {
            if s.isOpen(){
                s.close()
            }
            s.open(completionHandler: { (error) in
                if error == nil{
                    print("\(self.TAG) : KOSession Login: no error")
                    if s.isOpen(){
                        print("\(self.TAG) : KOSession Login : Success")
                        KOSessionTask.meTask { [weak self] (user, error) -> Void in
                            if error != nil {
                                print("\(self!.TAG) : KOSession Login : requestMe error = \(error)")
                                
                            } else {
                                if let user = user as? KOUser {
                                    print("\(self!.TAG) : KOSession Login : requestMe Success: id is = \(user.id!)")
                                    let id = String(describing: user.id!)
                                    self!.reqLogin(userId: id)
                                }
                            }
                        }
                    }else{
                        print("\(self.TAG) : KOSession Login: Fail")
                    }
                }else{
                    print("\(self.TAG) : KOSession Login: Error Login \(error)")
                }
            })
            
        }else{
            print("\(self.TAG) : KOSession Login: not session , somthing wrong")
        }
    }
    
    func share(){
        let text = "\(UserDefaultManager.init().getUserNick()) 님은 \(AppInfomation.name!)를 여행중 입니다 "
        let label = KakaoTalkLinkObject.createLabel(text)
        let img = KakaoTalkLinkObject.createImage("", width: 138, height: 88)
        let wepLink = KakaoTalkLinkObject.createWebLink(AppInfomation.name!, url: AppInfomation.koAppStoreLink!)
        
        
        let androidAppAction = KakaoTalkLinkAction.createAppAction(KakaoTalkLinkActionOSPlatform.android, devicetype: KakaoTalkLinkActionDeviceType.phone, execparam: [AppInfomation.name!:AppInfomation.koAppStoreLink!])
         let iphoneAppAction = KakaoTalkLinkAction.createAppAction(KakaoTalkLinkActionOSPlatform.IOS, devicetype: KakaoTalkLinkActionDeviceType.phone, execparam: [AppInfomation.name! :AppInfomation.koAppStoreLink!])
         let iPadAppAction = KakaoTalkLinkAction.createAppAction(KakaoTalkLinkActionOSPlatform.IOS, devicetype: KakaoTalkLinkActionDeviceType.pad, execparam: [AppInfomation.name! :AppInfomation.koAppStoreLink!])
        
        let appLink = KakaoTalkLinkObject.createAppButton(AppInfomation.name!, actions: [androidAppAction!,iphoneAppAction!,iPadAppAction!])
        
        if KOAppCall.canOpenKakaoTalkAppLink(){
            KOAppCall.openKakaoTalkAppLink([label!,wepLink!,appLink!])
        }else{
            print("\(self.TAG) : KOSession Share : cannot open kakaotalk")
        }
    }
    
    func reqLogin(userId : String){
        let path = HttpReqPath.LoginReq
        let parameters : [ String : String] = [
            "loggedincase" : LoggedInCase.kakaoLogin.description,
            "id" : userId
        ]
        self.userId = userId
        self.httpRequest!.connection(path, reqParameter: parameters)
    }
    
    func HttpSuccessResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        let data = resData["resultData"] as! NSDictionary
        let nick = data["nick"] as! String
        let accesstoken = data["accesstoken"] as! String
        
        NSLog("\(self.TAG) nick : \(nick)")
        NSLog("\(self.TAG) accesstoken : \(accesstoken)")
        
        if(nick == "-1" && accesstoken == "-1") {
            print("\(self.TAG) : User require join")
            let viewController = self.uvc!.storyboard?.instantiateViewController(withIdentifier: "JoinNickViewController") as! JoinNickViewController
            viewController.userId = self.userId
            viewController.loggedInCase = LoggedInCase.kakaoLogin
            let navController = UINavigationController(rootViewController: viewController)
            self.uvc!.present(navController, animated:true, completion: nil)
            
        }else{
            UserDefaultManager.init().loggedIn(self.uvc!, id: self.userId, nick: nick, accessToken: accesstoken, LoginCase: LoggedInCase.kakaoLogin.hashValue)
        }
        
        
        //go-> main
        
    }
    
    func HttpFailureResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject){
        
        if (resCode == "01"){
            
        }else if (resCode == "02"){
            
        }else if (resCode == "03"){
            
        }
    }
    
}
