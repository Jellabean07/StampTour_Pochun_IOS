//
//  MyLocationManager.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2016. 10. 27..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MyLocationManager  {
    
    var locationManager = CLLocationManager()
    init(locationManager : CLLocationManager) {
        self.locationManager = locationManager
    }
    
    func setLoactionManager(delegate : CLLocationManagerDelegate){
        locationManager.delegate = delegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            print("start loaction")
        }
        
    }
    

}
