//
//  StampAnimationView.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 10. 30..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class StampAnimationView : NSObject {
    private static let sharedInstance = StampAnimationView()
    private var popupView: UIImageView?
    
    override init() {
      
    }
    
    class func hide() {
        if let popupView : UIImageView = sharedInstance.popupView {
            popupView.stopAnimating()
            popupView.removeFromSuperview()
        }
    }
    
    class func show() {
        let popupView = UIImageView(frame: CGRect(x :0, y: 0, width: 300, height: 265))
        popupView.backgroundColor = UIColor.black
        popupView.animationImages = StampAnimationView.getAnimationImageArray()	// 애니메이션 이미지
        popupView.animationDuration = 2.0
        popupView.animationRepeatCount = 0	// 0일 경우 무한반복
        
        // popupView를 UIApplication의 window에 추가하고, popupView의 center를 window의 center와 동일하게 합니다.
        if let window = UIApplication.shared.keyWindow {
            
            window.alpha = 0.8
            
            window.addSubview(popupView)
            popupView.center = window.center
            popupView.startAnimating()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.popupView = popupView
        }
    }
    
    private class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "stamp_success1")!)
        animationArray.append(UIImage(named: "stamp_success2")!)
        animationArray.append(UIImage(named: "stamp_success3")!)
        animationArray.append(UIImage(named: "stamp_success4")!)
        animationArray.append(UIImage(named: "stamp_success5")!)
        
        return animationArray
    }
}
