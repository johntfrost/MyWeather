//
//  ViewController.swift
//  MyWeather
//
//  Created by John Frost on 12/24/15.
//  Copyright © 2015 Pair-A-Dice. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var weather: Weather!
    var manager: CLLocationManager!
    
    
    var latitude:String = ""
    var longitude:String = ""
    var lat:String = "35"
    var lon:String = "-84"
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initLocation()
         if manager.location != nil{
            latitude = "\(manager.location!.coordinate.latitude)"
            longitude = "\(manager.location!.coordinate.longitude)"
        }
       
        weather = Weather(latitude: latitude, longitude: longitude)
        weather.downloadWeather(latitude, longitude: longitude)
       
        
    }
    
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

