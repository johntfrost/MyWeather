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
    var location: Location!
    
    var latitude:String = ""
    var longitude:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location = Location()
        location.initLocation()
        
        if location.manager.location != nil{
            latitude = "\(location.manager.location!.coordinate.latitude)"
            longitude = "\(location.manager.location!.coordinate.longitude)"
        }
       
        weather = Weather(latitude: latitude, longitude: longitude)
        weather.downloadWeather(latitude, longitude: longitude)
       
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertController(title: "Failed to find user's location.", message: "Please try again later", preferredStyle: .Alert)
        let action = (UIAlertAction(title: "OK", style: .Default) { _ in})
        alert.addAction(action)
        self.presentViewController(alert, animated:true){}
    }
    
    
}

