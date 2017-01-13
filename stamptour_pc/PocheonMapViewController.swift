//
//  PocheonMapViewController.swift
//  stamptour_pc
//
//  Created by CSC-PC on 2017. 1. 13..
//  Copyright © 2017년 thatzit. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class PocheonMapViewController : UIViewController , MKMapViewDelegate, LocationProtocol{
    
    let TAG : String = "PocheonMapViewController"
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
        self.map.delegate = self
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
            let annotation = CustomPointAnnotation()
            let latitude = CLLocationDegrees(exactly: Double(row.latitude)!)
            let longitude = CLLocationDegrees(exactly: Double(row.longitude)!)
            let location = CLLocationCoordinate2DMake(latitude!, longitude!)
            annotation.coordinate = location
            annotation.title = row.title
            annotation.imageName = row.imgStr[0]
            print("\(TAG) : annotation imageName : \(row.imgStr[0])")
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        print("delegate called")
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView?.image = reSizeImage(name: cpa.imageName)
        
        return anView
    }
    
 
    func reSizeImage(name : String) -> UIImage{
        // Resize image
        let pinImage = FileBrowser.init().getImage(named: name)
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContext(size)
        pinImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    

}
