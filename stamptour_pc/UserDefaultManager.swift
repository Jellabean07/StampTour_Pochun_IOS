//
//  UserDefaultManager.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 23..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultManager{
    
    var defaultNick : String?
    var defaultId : String?
    var defaultToken : String?
    
    var LanguageCode : Int?
    
    var UserDefault : UserDefaults?
    
    init(){
        defaultNick = "사용자"
        defaultId = "아이디"
        defaultToken = "00"
        LanguageCode = LanguageInCase.kor.hashValue
        UserDefault =  UserDefaults.standard;
    }
    
    func setUserAccessToken(_ accessToken : String){
        self.UserDefault!.setValue(accessToken, forKey: "userAccessToken");
        self.UserDefault!.synchronize();
    }
    
    func setUserNick(_ nick : String) {
        self.UserDefault!.setValue(nick, forKey: "userNick");
        self.UserDefault!.synchronize();
    }
    
    func setUserId(_ id : String) {
        self.UserDefault!.setValue(id, forKey: "userId");
        self.UserDefault!.synchronize();
    }
    
    func setLoggedInState(_ isUserLoggedIn:Bool)
    {
        self.UserDefault!.set(isUserLoggedIn, forKey: "isUserLoggedIn");
        self.UserDefault!.synchronize();
    }
    
    
    func setLoggedCase(_ LoginCase:Int){
        self.UserDefault!.set(LoginCase, forKey: "isLoggedInCase");
        self.UserDefault!.synchronize();
    }
    
    func setLanguageCode(_ code : Int){
        self.UserDefault!.set(code, forKey: "LanguageCode");
        self.UserDefault!.synchronize();
    }

    
    func getUserNick() -> String {
        if let nick = self.UserDefault!.string(forKey: "userNick"){
            return nick
        }else{
            return self.defaultNick!
        }
    }
    
    func getUserId() -> String {
        if let id = self.UserDefault!.string(forKey: "userId"){
            return id
        }else{
            return self.defaultId!
        }
    }
    
    func getUserAccessToken() -> String {
        if let accessToken = self.UserDefault!.string(forKey: "userAccessToken"){
            return accessToken
        }else{
            return self.defaultToken!
        }
    }
    
    func getIsLoggedCase() -> Int {
        let LoggedCase = self.UserDefault!.integer(forKey: "isLoggedInCase")
        return LoggedCase
    }
    func getIsLoggedState() -> Bool{
        let state = self.UserDefault!.bool(forKey: "isUserLoggedIn")
        return state
    }


    
    func getLanguageCode() -> Int {
        if let LanguageCode : Int? = self.UserDefault!.integer(forKey: "LanguageCode"){
            return LanguageCode!
        }else{
            return self.LanguageCode!
        }
    }
  
    func loggedOut(uvc : UIViewController){
        self.UserDefault!.removeObject(forKey: "userId")
        self.UserDefault!.removeObject(forKey: "userNick")
        self.UserDefault!.removeObject(forKey: "userAccessToken")
        //self.UserDefault!.removeObjectForKey("LanguageCode")
        self.UserDefault!.set(false, forKey: "isUserLoggedIn");
        self.UserDefault!.removeObject(forKey: "isLoggedInCase");
        self.UserDefault!.synchronize();
        
        if let tbvc : MainViewController = uvc.tabBarController as! MainViewController{
            tbvc.locationManager.stopUpdatingLocation()
        }
        
        
        let viewController = uvc.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navController = UINavigationController(rootViewController: viewController)
        uvc.present(navController, animated:true, completion: nil)
        
    }
    
    func loggedIn(_ uvc : UIViewController, id : String , nick : String, accessToken : String, LoginCase : Int){
        self.UserDefault!.setValue(id, forKey: "userId");
        self.UserDefault!.setValue(nick, forKey: "userNick");
        self.UserDefault!.setValue(accessToken, forKey: "userAccessToken")
       // self.UserDefault!.setValue(code, forKey: "LanguageCode")
        self.UserDefault!.set(true, forKey: "isUserLoggedIn");
        self.UserDefault!.set(LoginCase, forKey: "isLoggedInCase");
        self.UserDefault!.synchronize();
        ContentsManager.init(uvc: uvc).versionCheck()
        
    }
    
    func removeUserNick_ID() {
        UserDefaults.standard.removeObject(forKey: "userNick")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.synchronize();
    }
    
}
