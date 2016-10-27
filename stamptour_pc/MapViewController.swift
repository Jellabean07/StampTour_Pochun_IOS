//
//  MapViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController , MKMapViewDelegate, CLLocationManagerDelegate, HttpResponse{
    
    let TAG : String = "MapViewController"
    var httpRequest : HttpRequestToServer?
    var locationManager = CLLocationManager()
    
    @IBOutlet var map: MKMapView!
    
    @IBAction func MyLocation_btn(_ sender: AnyObject) {
        setLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.httpRequest = HttpRequestToServer.init(TAG: TAG, delegate : self)
        
        setLoactionManager()
      
    }
    
    func setLoactionManager(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
    }
    
    func setAnotation(){
//        var annotation = MKPointAnnotation()
//        annotation.coordinate = self.location!
//        annotation.title = "test"
//        annotation.subtitle = "test sub"
//        
//        map.addAnnotation(annotation)
    }
    
    func setLocation(){
//        var span = MKCoordinateSpanMake(0.0002, 0.0002)
//        var region = MKCoordinateRegion(center: self.location!, span: span)
//        map.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        
        
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegion(center: center, span: span)
        self.map.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : \(error.localizedDescription)")
    }
    
    func HttpResult(_ reqPath : String, resCode: String, resMsg: String, resData: AnyObject) {
        //let data = resData["resultData"] as! String
        
    }
}
