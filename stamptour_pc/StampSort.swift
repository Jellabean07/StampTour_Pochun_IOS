//
//  StampSort.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 11. 23..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation


class StampSort{
    
    class var shared: StampSort {
        struct Static {
            static let instance: StampSort = StampSort()
        }
        return Static.instance
    }
    
    func sortByRegion(towns : [TownVO]) -> [TownVO]{
        return towns.sorted{ $0.regionCode < $1.regionCode }
    }
    
    func sortByName(towns : [TownVO]) -> [TownVO]{
        return towns.sorted{ $0.title < $1.title }
    }
    
    func sortByDistance(towns : [TownVO]) -> [TownVO]{
        let sortobj = towns.sorted{ $0.distance < $1.distance }
       return sortobj.sorted{ $0.distance < $1.distance }
    }
}
