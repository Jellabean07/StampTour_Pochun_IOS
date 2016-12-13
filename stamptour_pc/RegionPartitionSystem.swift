//
//  RegionPartitionSystem.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 1..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit


class RegionPartitionSystem  {
    
    class var shared: RegionPartitionSystem {
        struct Static {
            static let instance: RegionPartitionSystem = RegionPartitionSystem()
        }
        return Static.instance
    }
    
    func setResourse(){
        
        let region = ResRegion.shinan
        AppInfomation.region = region.hashValue
        
        AppInfomation.themeColor = region.mainColor
        AppInfomation.name = region.appName
        
        AppInfomation.pakageName = region.appPakage
        AppInfomation.host = region.appHost
        
        AppInfomation.localizeCode = LocalizationManager.shared.getLanguageCode()
        AppInfomation.fbAppKey = region.fbAppKey
        AppInfomation.fbAppStoreLink = region.fbAppStoreLink
        AppInfomation.koAppKey = region.koAppKey
        AppInfomation.koAppStoreLink = region.koAppStoreLink
        
        print("RegionPartitionSystem : \(region.appName)")
        print("RegionPartitionSystem : region : \(AppInfomation.region!)")
        print("RegionPartitionSystem : themeColor : \(AppInfomation.themeColor!)")
        print("RegionPartitionSystem : pakageName : \(AppInfomation.pakageName!)")
        print("RegionPartitionSystem : appHost : \(AppInfomation.host!)")
        print("RegionPartitionSystem : fbAppKey : \(AppInfomation.fbAppKey!)")
        print("RegionPartitionSystem : fbAppStoreLink : \(AppInfomation.fbAppStoreLink!)")
        print("RegionPartitionSystem : koAppKey : \(AppInfomation.koAppKey!)")
        print("RegionPartitionSystem : koAppStoreLink : \(AppInfomation.koAppStoreLink!)")

    }
    
    
    func adjust(){
        
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
