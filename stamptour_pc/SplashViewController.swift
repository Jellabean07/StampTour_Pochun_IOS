//
//  SplashViewController.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 2..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController : UIViewController{
    
    @IBOutlet var bgImg: UIImageView!
    @IBOutlet var logoImg: UIImageView!
    @IBOutlet var applyName: UILabel!
    
    let TAG = "SplashViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDefaultManager.init().setFirst(true)
        callTimer()
       
        
    }
    
      
    func show() {
//        if(UserDefaultManager.init().getIsLoggedState()){
//            SideBarSetupGo.init().startSideBarThemeViewController()
//        }else{
//            self.performSegue(withIdentifier: "showApp", sender: self)
//        }
         self.performSegue(withIdentifier: "showApp", sender: self)
    }
    
    func callTimer(){
        let timer = Timer.scheduledTimer(
            timeInterval: 3.0, target: self, selector: #selector(UIAlertView.show), userInfo: nil, repeats: false
        )
    }
    

}
