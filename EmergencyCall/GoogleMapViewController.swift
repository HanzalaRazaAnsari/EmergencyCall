//
//  GoogleMapViewController.swift
//  EmergencyCall
//
//  Created by Axiom1 on 6/4/18.
//  Copyright © 2018 Axiom HK 14. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapViewController: UIViewController , CLLocationManagerDelegate , GMSMapViewDelegate {

    @IBOutlet weak var CancelOutlet: RoundButton!
    @IBOutlet weak var SearchingOutlet: UIView!
    @IBOutlet weak var MapView: GMSMapView!
    @IBOutlet weak var EmergencyOutlet: RoundButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        SearchingOutlet.isHidden = true
//        CancelOutlet.isHidden = true
        
    let camera = GMSCameraPosition.camera(withLatitude: 24.861310, longitude: 67.073369, zoom: 18)
    let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
    mapView.isMyLocationEnabled = true
    view = mapView
    

        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 24.861310, longitude: 67.073369)
        marker.title = "Ambulance"
        marker.snippet = "Baloch Colony"
        marker.map = mapView
        
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = 30
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//        placesClient = GMSPlacesClient.shared()
}
//
//    var locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//    var mapView: GMSMapView!
//    var placesClient: GMSPlacesClient!
//    var zoomLevel: Float = 10.0

    @IBAction func EmergencyCall(_ sender: Any) {
        
        SearchingOutlet.isHidden = false
        CancelOutlet.isHidden = false
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}



