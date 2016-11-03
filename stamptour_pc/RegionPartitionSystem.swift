//
//  RegionPartitionSystem.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit


class RegionPartitionSystem : NSObject {
    private static let sharedInstance = RegionPartitionSystem()
    
    override init() {
        
    }
    
    func show(regionInCase : Int){
        switch regionInCase {
        case RegionInCase.pochun.hashValue:
            break
        case RegionInCase.shinan.hashValue:
            break
        default:
            break
        }
    }
    
    func setRegion(regionInCase : Int){
        //패키지명변경
        //앱이름 변경
        //앱아이콘변경
        //스탬프이미지변경
        //스플래시 이미지변경
        //앱 배경색 변경
        //텍스트변경
    }
    
}
