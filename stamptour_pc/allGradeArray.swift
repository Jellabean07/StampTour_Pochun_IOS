//
//  allGradeArray.swift
//  stamptour_pc
//
//  Created by kjw on 2016. 11. 4..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
class allGradeArray{
    init() {
        self.list = Array<allGradeVO>()
    }
    var list :Array<allGradeVO>?
    var count :Int?
    func addItem(allGradeItem:allGradeVO) {
        list?.append(allGradeItem)
    }
}
