//
//  StampGuideOverlay.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 12. 26..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class StampGuideOverlay{
    
    
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
        let strImageName : String = "img_stamp_popup.png"
        let image  = UIImage(named:strImageName)
    
        
        imageView.center = overlay.center
        imageView.image = image
    
        overlay.addSubview(imageView)
        
        let tapPressGesture = UITapGestureRecognizer()

        
        // add target for long press
        tapPressGesture.addTarget(self, action: #selector(StampGuideOverlay.tapPress))
        

        
        // add long press gesture in to view
        // Create label
        
        let guide_msg = NSLocalizedString("main_stamp_guide_hide", comment: "마을은 옆으로 밀어서 숨길수 있어요")
        if let textString : String  = guide_msg {
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
        currentOverlay?.addGestureRecognizer(tapPressGesture)
    }
    
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }
    @objc static func tapPress(){
        print("tap press")
        self.hide()
    }
  
    
}
