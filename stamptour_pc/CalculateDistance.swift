//
//  CalculateDistance.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 10. 27..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class CalculateDistance {
    var TAG : String = "CalculateDistance"
 
    func deg2rad(deg:Double) -> Double {
        return deg * M_PI / 180
    }
    
    ///////////////////////////////////////////////////////////////////////
    ///  This function converts radians to decimal degrees              ///
    ///////////////////////////////////////////////////////////////////////
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / M_PI
    }
    
    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }
        else if (unit == "N") {
            dist = dist * 0.8684
        }
        return roundToPlaces(value: dist, places: 3)
    }
    
    func roundToPlaces(value : Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    

}

