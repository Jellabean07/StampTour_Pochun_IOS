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
        
        AppInfomation.localizeName = LocalizationManager.shared.getLanguageCode()
        AppInfomation.localizeCode = LocalizationManager.shared.getLanguageCodeInt()
        AppInfomation.surpportLng = region.supportLanguage
        AppInfomation.fbAppKey = region.fbAppKey
        AppInfomation.fbAppStoreLink = region.fbAppStoreLink
        AppInfomation.koAppKey = region.koAppKey
        AppInfomation.koAppStoreLink = region.koAppStoreLink
        AppInfomation.appStoryboard = region.appStoryboard
        
        print("RegionPartitionSystem : \(region.appName)")
        print("RegionPartitionSystem : region : \(AppInfomation.region!)")
        print("RegionPartitionSystem : themeColor : \(AppInfomation.themeColor!)")
        print("RegionPartitionSystem : pakageName : \(AppInfomation.pakageName!)")
        print("RegionPartitionSystem : appHost : \(AppInfomation.host!)")
        print("RegionPartitionSystem : localizeName : \(AppInfomation.localizeName!)")
        print("RegionPartitionSystem : localizeCode : \(AppInfomation.localizeCode!)")
        print("RegionPartitionSystem : surpportLng : \(AppInfomation.surpportLng!)")
        print("RegionPartitionSystem : fbAppKey : \(AppInfomation.fbAppKey!)")
        print("RegionPartitionSystem : fbAppStoreLink : \(AppInfomation.fbAppStoreLink!)")
        print("RegionPartitionSystem : koAppKey : \(AppInfomation.koAppKey!)")
        print("RegionPartitionSystem : koAppStoreLink : \(AppInfomation.koAppStoreLink!)")
        print("RegionPartitionSystem : appStoryboard : \(AppInfomation.appStoryboard!)")

    }
        
}
