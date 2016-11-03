//
//  StampSealListener.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 10. 30..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

protocol StampSeal{
    func Seal(_ town_code : String, latitude : String, longitude : String)
    
}

class StampSealProtocol {
    var TAG : String?
    var delegate : HttpResponse?

    
    init(TAG : String, delegate : HttpResponse){
        self.TAG = TAG
        self.delegate = delegate
    
    }
    
    
}
