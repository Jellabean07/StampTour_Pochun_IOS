//
//  MainViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController : UITabBarController , CLLocationManagerDelegate{
    var TAG : String = "MainViewController"
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog(TAG,"kkkkkkkkkkkkkkkkk")
        print("aaaaaaaaaaaaaaaaaaasaa")
       //self.setLoactionManager()
    }
    

    
    func setLoactionManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
             print("bbbbbbbbbbbbbbbbbbbbbbb")
        }
        
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        manager.stopUpdatingLocation()
        NSLog(TAG,"user latitude = \(userLocation.coordinate.latitude)")
        NSLog(TAG,"user longitude = \(userLocation.coordinate.longitude)")
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error.localizedDescription)")
    }

}
