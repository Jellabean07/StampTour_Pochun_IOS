//
//  LoggedInCaseVO.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 25..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class LoggedInCaseVo {
    
    init(){
        userdefaultmanager = UserDefaultManager.init()
    }
    var userdefaultmanager:UserDefaultManager?
    
    func LoggedInCaseChecker(_ Sender:UIViewController){
        var Case_LoggedIn = userdefaultmanager!.getIsLoggedCase()
        if(LoggedInCase.fbLogin.hashValue == Case_LoggedIn || LoggedInCase.kakaoLogin.hashValue == Case_LoggedIn){
//            let viewController = Sender.storyboard?.instantiateViewControllerWithIdentifier("OauthMyInfoViewController") as! OauthMyInfoViewController
//            let navController = UINavigationController(rootViewController: viewController)
//            Sender.presentViewController(navController, animated:true, completion: nil)
            
        }else {
            Sender.performSegue(withIdentifier: "InfoWind", sender: Sender)
        }
    }
    
    func LoggedInCaseChecker(_ value:Int)-> Int{
        
        switch value {
        case LoggedInCase.fbLogin.hashValue:return 0
        case LoggedInCase.kakaoLogin.hashValue:return 1
        case LoggedInCase.normal.hashValue:return 2
        default:
            return -1
        }
    }
}
