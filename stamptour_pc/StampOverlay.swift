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

    static var isOverlay : Bool = false
    
    static var currentOverlay : UIView?
    static var delegate : StampSeal?
    static var town_code : String?
    static var latitude : String?
    static var longitude : String?
    
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
        self.isOverlay = true
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0.9
        overlay.backgroundColor = UIColor.black
        overlayTarget.addSubview(overlay)
        //overlayTarget.bringSubview(toFront: overlay)
        
        
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
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 1.0
        
        // add target for long press
        longPressGesture.addTarget(self, action: #selector(StampOverlay.longPressSeal))
        
        // add long press gesture in to view
        // Create label
        if let textString : String  = "터치를 길게 눌러서 스탬프를 찍어주세요" {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.sizeToFit()
            label.center = CGPoint(x: imageView.center.x, y: imageView.center.y + 160)
            overlay.addSubview(label)
        }
        
        
        // Animate the overlay to show
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(0.5)
//        overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
//        UIView.commitAnimations()
//        
        currentOverlay = overlay
        currentOverlay?.addGestureRecognizer(longPressGesture)
    }
    
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }

    @objc static func longPressSeal(){
        print("long press")
        self.hide()
        self.delegate?.Seal(self.town_code!, latitude: self.latitude!, longitude: self.longitude!)
    }
   
    
}
