//
//  HttpResponseProtocol.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 2..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation

protocol HttpResponse{
    func HttpResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject)
    
}


protocol HttpDownResponse{
    func HttpDownResult(_ reqPath : String, resCode : String, resMsg : String, resData : AnyObject)
    
}
