//
//  StampOverlay.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 15..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class StampOverlay{

    var isOverlay : Bool = false
    
    static var currentOverlay : UIView?
   
    
    
    static func show() {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow)
    }
    
    static func show(_ loadingText: String) {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow, loadingText: loadingText)
    }
    
    static func show(_ overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    
    static func show(_ overlayTarget : UIView, loadingText: String?) {
        // Clear it first in case it was already shown
        hide()
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0.9
        overlay.backgroundColor = UIColor.black
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubview(toFront: overlay)
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 275))
        //add images to the array
        var imagesListArray : [UIImage] = []
        //use for loop
        for position in 1...5
        {
            
            var strImageName : String = "stamp_success\(position).png"
            var image  = UIImage(named:strImageName)
            imagesListArray.append(image!)
        }

        imageView.center = overlay.center
        imageView.animationImages = imagesListArray;
        imageView.animationDuration = 1.5
        imageView.startAnimating()
        overlay.addSubview(imageView)
        
        let longGesture = UILongPressGestureRecognizer(target: imageView, action:  #selector(hide))
        currentOverlay?.addGestureRecognizer(longGesture)
        
        // Animate the overlay to show
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(0.5)
//        overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
//        UIView.commitAnimations()
//        
        currentOverlay = overlay
    }
    
    @objc static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }

    
    func isOverlayState() -> Bool{
        return isOverlay
    }
}
