//
//  ActionVO.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 25..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class ActionVO{
    
    init(title:String,action:@escaping (Void)->Void){
        self.title = title
        self.action = action
    }
    
    
    var title:String
    var action:(Void)->Void
    
    func play(){
        self.action()
    }
}
