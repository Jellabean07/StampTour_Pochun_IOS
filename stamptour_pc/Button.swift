//
//  Button.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 16..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SubmitButton: UIButton {

    
    //this init fires usually called, when storyboards UI objects created:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    //This method is called during programmatic initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {
        //your common setup goes here
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.layer.backgroundColor = AppInfomation.themeColor?.cgColor
    }
    
    //required method to present changes in IB
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupViews()
    }

    
}


@IBDesignable
class OverlapButton: UIButton {
    
    
    //this init fires usually called, when storyboards UI objects created:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    //This method is called during programmatic initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {
        //your common setup goes here
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1
        self.layer.borderColor = AppInfomation.themeColor?.cgColor
        self.setTitleColor(AppInfomation.themeColor!, for: UIControlState.normal)
      
        self.layer.masksToBounds = true
    }
    
    //required method to present changes in IB
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupViews()
    }
    
    
}

