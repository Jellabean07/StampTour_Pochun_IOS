//
//  allGradeVO.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 4..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
class allGradeVO{
    init() {
        
    }
    init(grade:String,stamp_count:Int) {
        self.grade = grade
        self.stamp_count = stamp_count
    }
    var grade :String?
    var stamp_count :Int?
}
