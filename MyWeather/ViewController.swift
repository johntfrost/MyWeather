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
    
  
    

}

