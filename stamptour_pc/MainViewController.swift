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
    var delegateLoc : LocationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setLoactionManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setLoactionManager()
    }
    
    func setDelegate(delegate : LocationProtocol){
        self.delegateLoc = delegate
    }
    
    func setLoactionManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            print("\(TAG) : start loaction")
        }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        let latitude = Double(location!.coordinate.latitude)
        let logitude = Double(location!.coordinate.longitude)
        print("\(TAG) : user latitude = \(location!.coordinate.latitude)")
        print("\(TAG) : user longitude = \(location!.coordinate.longitude)")
        
        self.delegateLoc?.LocationSuccessReceive(latitude: latitude, longitude: logitude)
        
        //self.locationManager.stopUpdatingLocation()
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegateLoc?.LocationFailureReceive(didFailWithError: error)
        print("\(TAG) : Error \(error.localizedDescription)")
    }

}
