//
//  MapViewController.swift
//  emergencycallalipanhwar
//
//  Created by Mohammad ali panhwar on 5/24/18.
//  Copyright © 2018 Mohammad ali panhwar. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SSBouncyButton


class MapViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate{
    
    @IBOutlet weak var CancelDriver: UIButton!
   
    @IBAction func SideMenu(_ sender: Any) {
        performSegue(withIdentifier: "tosidemenu", sender: nil)
    }
    
    @IBOutlet weak var ambulance: UILabel!
    @IBOutlet weak var DriverName: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var callDrive: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var emergencyCall: UIButton!
 
    @IBOutlet weak var map1: GMSMapView!
    
    
   
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    var myLocation:CLLocationCoordinate2D?
    
    let marker = GMSMarker()
    var marker2 = GMSMarker()
    
    var value = 0.0
    var timer:Timer!
    let a = "Edhi"
    let d = "Hanzala Raza"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        sideMenus()
        
        
        userView.isHidden = true
        callDrive.isHidden = true
        

        let camera = GMSCameraPosition.camera(withLatitude: 38.332442, longitude: -123.032234, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.map1.camera = camera
       
        // User Location
        locationManager.delegate = self
        self.map1.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        map1.isMyLocationEnabled = true
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation1 = locations.last
        let location1 = CLLocationCoordinate2D(latitude: (userLocation1?.coordinate.latitude)!, longitude: (userLocation1?.coordinate.longitude)!)
        
        myLocation = location1
        let camera = GMSCameraPosition.camera(withLatitude: (userLocation1?.coordinate.latitude)!,longitude: (userLocation1?.coordinate.longitude)!, zoom: 13.0)
        map1.camera = camera
        self.map1?.animate(to: camera)

     
        locationManager.stopUpdatingLocation()
        
     
  
    }



    func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            
             let json = try! JSON(data: response.data!)
             let routes = json["routes"].arrayValue
            
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = self.map1
                }
                
            
            
        }
    }
    func driverAcceptedRequest(requestAccepted: Bool, driverName: String) {
        if requestAccepted {
            UserRequest(title: "Emergency Accepted", message: "\(driverName) accepted your Emergency")
        }else {
            UserRequest(title: "the request was cancelled", message: "")
        }
    }
    private func UserRequest(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
   
    @IBAction func CallDriveButton(_ sender: Any) {
 
    drawPath(startLocation: myLocation!, endLocation: marker2.position)
        DriverName.text = d
        ambulance.text = a
        self.callDrive.isHidden = true
        self.CancelDriver.isHidden = false
        self.userView.isHidden = false
        
        
    }
    @IBAction func emergencyCallButton(_ sender: Any) {
    self.loadingView.isHidden = false
        self.cancel.isHidden = false
        if self.cancel.isHidden == false {

            self.emergencyCall.isHidden = true


        }
        DriverName.text = d
        ambulance.text = a
          timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)

      
//        _ = Timer(timeInterval: 15, target: self, selector: #selector(load), userInfo: nil, repeats: true)

        
        marker2.title = "\(a)\(d)"
        marker2.position = CLLocationCoordinate2D(latitude: 24.9071 ,longitude: 67.1102)
        marker2.icon = imageWithImage(image:#imageLiteral(resourceName: "AmbulanceAman"), scaledToSize: CGSize(width: 50.0, height: 50.0))
        marker2.map = map1
        
        
    }
    @objc func update(){
        value = value + 0.01
        self.emergencyCall.isHidden = true
        self.loadingView.isHidden = false
        self.cancel.isHidden = false
        if value >= 1.0{
            timer.invalidate()
            timer = nil
            
        self.callDrive.isHidden = false
            self.loadingView.isHidden = true
            self.cancel.isHidden = true
        self.userView.isHidden = false
        }
    }
    @objc func update1(){
        value = value + 0.01
        self.emergencyCall.isHidden = true
        self.loadingView.isHidden = false
        self.cancel.isHidden = false
        if value >= 1.0{
            timer.invalidate()
            timer = nil
            self.dismiss(animated: true, completion: nil)
            self.callDrive.isHidden = false
            self.loadingView.isHidden = true
            self.cancel.isHidden = true
            self.userView.isHidden = false
        }
    }
    
//    @objc func load() {
//        self.loadingView.isHidden = false
//        self.cancel.isHidden = false
//    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    @IBAction func cancelButton(_ sender: Any) {
        cancel.isHidden = true

        loadingView.isHidden = true
        if cancel.isHidden == true {
            emergencyCall.isHidden = false
        }
    }
//    func sideMenus() {
//
//        if revealViewController() != nil {
//
//            sideMenu.target = revealViewController()
//            sideMenu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
//            revealViewController().rightViewRevealWidth = 300
//             view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//
//
//        }
    
    
    
    
    @IBAction func CancelDriverButton(_ sender: Any) {
        self.callDrive.isHidden = false
        self.CancelDriver.isHidden = true
        self.userView.isHidden = false
        map1.clear()
        marker2.title = "\(a)\(d)"
        marker2.position = CLLocationCoordinate2D(latitude: 24.9071 ,longitude: 67.1102)
        marker2.icon = imageWithImage(image: #imageLiteral(resourceName: "AmbulanceAman"), scaledToSize: CGSize(width: 50.0, height: 50.0))
        marker2.map = map1
    }


}
