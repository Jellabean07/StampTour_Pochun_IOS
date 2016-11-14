//
//  LocationProtocol.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 14..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


protocol LocationProtocol{
    func LocationSuccessReceive(latitude : Double, longitude : Double)
    func LocationFailureReceive(didFailWithError error: Error )
    
}
