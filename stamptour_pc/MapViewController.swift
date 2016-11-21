//
//  MapViewController.swift
//  StampTour_GJ
//
//  Created by CSC-PC on 2016. 9. 8..
//  Copyright © 2016년 thatzit. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController : UIViewController , MKMapViewDelegate, LocationProtocol{
    
    let TAG : String = "MapViewController"
    var contents : [ContentsVO]?
    var loactions : [CLLocation]?
    var fisrtFlag : Bool? = true
    
    @IBOutlet var map: MKMapView!
    
    @IBAction func MyLocation_btn(_ sender: AnyObject) {
        setLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.map.showsUserLocation = true
        setContentsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tbvc = self.tabBarController as! MainViewController
        tbvc.setDelegate(delegate: self)
        self.fisrtFlag = true
    }
    
    func setContentsData(){
        if let contents : [ContentsVO] = StampDefaultManager.init().getTownList(){
            self.contents = contents
            setAnotation()
            print("\(TAG) : Success Receive Cotnent Data")
        }else{
            self.contents = [ContentsVO]()
        }
    }
    

    
    func setAnotation(){
        for row in self.contents!{
            let annotation = MKPointAnnotation()
            let latitude = CLLocationDegrees(exactly: Double(row.latitude)!)
            let longitude = CLLocationDegrees(exactly: Double(row.longitude)!)
            let location = CLLocationCoordinate2DMake(latitude!, longitude!)
            annotation.coordinate = location
            annotation.title = row.title
            //annotation.subtitle = row.region
            
           
            map.addAnnotation(annotation)
            //map.selectAnnotation(annotation, animated: true)
            
        }
       
    }
    
    func setLocation(){
        if let location : CLLocation = self.loactions?.last{
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
            print("\(TAG) : my loction")
            
            let span = MKCoordinateSpanMake(0.15, 0.15)
            let region = MKCoordinateRegion(center: center, span: span)
            self.map.setRegion(region, animated: true)
        }else{
            print("\(TAG) : not find loction")
        }
    }
    
    
    func LocationSuccessReceive(locations : [CLLocation], latitude : Double, longitude : Double){
        print("\(TAG) : LocationSuccessReceive")
        self.loactions = locations
        if self.fisrtFlag! {
            self.fisrtFlag = false
            setLocation()
        }
        
    }
    
    func LocationFailureReceive(didFailWithError error: Error ){
        print("\(TAG) : LocationFailureReceive")
    }
}
