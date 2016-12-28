//
//  LoadingOverlay.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 12..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class LoadingOverlay{
    
    
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    
    func showOverlay(view: UIView) {
        view.isUserInteractionEnabled = false
        overlayView.frame = CGRect(x : 0,y : 0, width: 80,height: 80) // 375 , 667
        overlayView.center = view.center
        //overlayView.backgroundColor = UIColor(white: 0x444444, alpha: 0.7)
        //overlayView.backgroundColor = UIControlManager.init().colorWithHexString("#b3444444")
        overlayView.backgroundColor = UIControlManager.init().colorWithHexString("#ffffffff")
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame =  CGRect(x : 0,y : 0, width: 40,height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
