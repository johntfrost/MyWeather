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
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    
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
        weather.downloadWeather(latitude, longitude: longitude) { () -> () in
            
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        print(weather.cityName)
        print(weather.temp)
        print(weather.pressure)
        print(weather.humidity)
        print(weather.weather1)
        print(weather.weather2)
        print(weather.icon)
        print(weather.cloudCover)
        print(weather.windSpeed)
        print(weather.windDir)
        print(weather.rain)
        print(weather.dateTime)
        
        
        locationLbl.text = weather.cityName
        print(locationLbl.text)
//
//        weatherIcon.image = UIImage(named: weather.icon)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertController(title: "Failed to find user's location.", message: "Please try again later", preferredStyle: .Alert)
        let action = (UIAlertAction(title: "OK", style: .Default) { _ in})
        alert.addAction(action)
        self.presentViewController(alert, animated:true){}
    }
    
    
    
}
