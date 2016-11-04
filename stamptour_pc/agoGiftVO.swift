//
//  agoGiftVO.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 4..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
class agoGiftVO{
    init() {
        
    }
    init(grade:String,check_time:String) {
        self.grade = grade
        self.check_time = check_time
    }
    var grade :String?
    var check_time :String?
}
