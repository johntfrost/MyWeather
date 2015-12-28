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


    func initLocation() {
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Captures user location from GPS in lat/long
        let userLocation:CLLocation = locations[0]
        self.latitude = "\(userLocation.coordinate.latitude)"
        self.longitude = "\(userLocation.coordinate.longitude)"
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertController(title: "Failed to find user's location.", message: "Please try again later", preferredStyle: .Alert)
        let action = (UIAlertAction(title: "OK", style: .Default) { _ in})
        alert.addAction(action)
        self.presentViewController(alert, animated:true){}
    }
    
}
