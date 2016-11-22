//
//  StampDefaultManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class StampDefaultManager{

    let userDefault : UserDefaults?
    init() {
        self.userDefault = UserDefaults.standard
    }
    
    
    func setTownList(townList : [ContentsVO]){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: townList)
        print("encodedData: \(encodedData)")
        self.userDefault?.set(encodedData, forKey: "townList")
        self.userDefault?.synchronize()
    }
    
    func getTownList() -> [ContentsVO] {
        if let data = self.userDefault?.object(forKey: "townList"),
            let townList = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [ContentsVO] {
            return townList
        } else {
            print("There is an issue")
            return  [ContentsVO]()
        }
    }
    
    func setTowns(towns : [TownVO]){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: towns)
        print("encodedData: \(encodedData)")
        self.userDefault?.set(encodedData, forKey: "towns")
        self.userDefault?.synchronize()
    }
    
    func getTowns() -> [TownVO] {
        if let data = self.userDefault?.object(forKey: "towns"),
            let towns = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [TownVO] {
            return towns
        } else {
            print("There is an issue")
            return  [TownVO]()
        }
    }
    
    func setHideItem(townCode : Int){
        var hide : [Int]?
        if let data = self.userDefault?.object(forKey: "hide"){
            hide = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Int]
        }else{
            hide = [Int]()
        }
        hide?.append(townCode)
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: hide)
        self.userDefault?.set(encodedData, forKey: "hide")
        self.userDefault?.synchronize()
    }
    
    func getHideItem() -> [Int]{
        if let data = self.userDefault?.object(forKey: "hide"){
            return (NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Int])!
        }else{
            return [Int]()
        }
    }
    
    func deleteHideItem(townCode : Int){
        if let data = self.userDefault?.object(forKey: "hide"){
           var hide = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Int]
            for (index,row) in hide!.enumerated(){
                if row == townCode {
                    hide!.remove(at: index)
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: hide)
                    self.userDefault?.set(encodedData, forKey: "hide")
                    self.userDefault?.synchronize()
                    break
                }
            }
        }
        
    }
    
}
