//
//  Location.swift
//  MyWeather
//
//  Created by John Frost on 12/24/15.
//  Copyright © 2015 Pair-A-Dice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class Location: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var manager: CLLocationManager!
    
    var latitude:String = ""
    var longitude:String = ""
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func getLocation() {
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        print(latitude)
        print(longitude)
    }
    

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        //Captures user location from GPS in lat/long
        let userLocation:CLLocation = locations[0]
        print(userLocation)
        latitude = "\(userLocation.coordinate.latitude)"
        longitude = "\(userLocation.coordinate.longitude)"
    }

}
