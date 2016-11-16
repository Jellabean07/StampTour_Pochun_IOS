//
//  CommonFunction.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 5..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit


class CommonFunction {
    
    
    static func dismiss(_ selfView : UIViewController){
        if(selfView == selfView.navigationController?.viewControllers[0]){
            selfView.dismiss(animated: true, completion: nil)
        }else{
            selfView.navigationController?.popViewController(animated: true)
        }
    }
    
    static func moveToController(uvc : UIViewController){
        typealias viewControllerType = MainViewController
        let viewController = uvc.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! viewControllerType
        
        uvc.present(viewController, animated:true, completion: nil)
        
//        let navController = UINavigationController(rootViewController: viewController)
//        uvc.present(navController, animated:true, completion: nil)
    }
}
