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
            townList.forEach({print( $0.no, $0.title)})  // Joe 10
            print("There is an townList")
            return townList
        } else {
            print("There is an issue")
            return  [ContentsVO]()
        }
        
        
        

    }
    
}
