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
}
