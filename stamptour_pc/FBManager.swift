//
//  FBLoginManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 24..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        init(rawResponse: Any?) {
            // Decode JSON from rawResponse into other properties here.
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}


class FBManager : HttpResponse{
    
    let TAG : String = "FBManager"
    var httpRequest : HttpRequestToServer?
    var uvc : UIViewController?
    var userId : String = ""
    
    
    
    init(uvc : UIViewController) {
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        self.uvc = uvc
    }
    
    func getReturnState(){
        //login()
        AccessToken.refreshCurrentToken()
        if let accessToken = AccessToken.current {
            
            // User is logged in, use 'accessToken' here.
            self.userId = accessToken.userId!
            reqLogin(userId: accessToken.userId!)
        }else{
            login()
        }
    }
    
    func share(){
        let content = LinkShareContent(url: NSURL(string: AppInfomation.fbAppStoreLink!) as! URL)
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .automatic
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            // Handle share results
        }
        
        do {
            try shareDialog.show()
        } catch  {
            
        }
    }
    
    func logout(){
        let loginManager = LoginManager()
        loginManager.logOut()
        print("\(self.TAG) : AccessToken.current :  logout : \(AccessToken.current)")
        AccessToken.refreshCurrentToken()
        
    }
    
    func login(){
        print("\(self.TAG) : AccessToken.current : login : \(AccessToken.current)")
        let loginManager = LoginManager()
        print("\(self.TAG) : user  loging!!!!!!!")
         loginManager.logIn([ .publicProfile ], viewController: self.uvc!) { loginResult in
            switch loginResult {
            case .failed(let error):
                print("\(self.TAG) : user failed login")
                print("\(self.TAG) : \(error)")
            case .cancelled:
                print("\(self.TAG) : User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("\(self.TAG) : User success login.")
                print("\(self.TAG) : grantedPermissions : \(grantedPermissions)")
                print("\(self.TAG) : declinedPermissions : \(declinedPermissions)")
                print("\(self.TAG) : accessToken : \(accessToken)")
                let token = accessToken
                print("\(self.TAG) : Logged in! : userId = \(token.userId!)")
                self.userId = token.userId!
                self.reqLogin(userId: token.userId!)
                self.returnUserData(loginManager: loginManager)
            }
            
        }
    }
    
    func returnUserData(loginManager : LoginManager){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me")) { httpResponse, result in
            switch result {
            case .success(let response):
                print("\(self.TAG) : Custom Graph Request Succeeded: \(response)")
                print("\(self.TAG) : My facebook id is \(response.dictionaryValue?["id"])")
                print("\(self.TAG) : My name is \(response.dictionaryValue?["name"])")

            case .failed(let error):
                print("\(self.TAG) : Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
  
    
    func reqLogin(userId : String){
        let path = HttpReqPath.LoginReq
        let parameters : [ String : String] = [
            "loggedincase" : LoggedInCase.fbLogin.description,
            "id" : userId
        ]
        
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
            viewController.loggedInCase = LoggedInCase.fbLogin
            let navController = UINavigationController(rootViewController: viewController)
            self.uvc!.present(navController, animated:true, completion: nil)
            
        }else{
            UserDefaultManager.init().loggedIn(self.uvc!, id: self.userId, nick: nick, accessToken: accesstoken, LoginCase: LoggedInCase.fbLogin.hashValue)
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
