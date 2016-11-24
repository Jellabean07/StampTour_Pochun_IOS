//
//  ActionParaVO.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 8. 25..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

class ActionParaVO{
    
    init(title:String,action:@escaping (String)->Void){
        self.title = title
        self.action = action
    }
    
    
    
    var title:String
    var action:(String)->Void
    
    func play(){
        self.action(title)
    }
}

class ActionCodeVO{
    
    init(title:String, code:Int,action:@escaping (String,Int)->Void){
        self.title = title
        self.code = code
        self.action = action
    }
    
    
    var title:String
    var code:Int
    var action:(String,Int)->Void
    
    func play(){
        self.action(title,code)
    }
}
