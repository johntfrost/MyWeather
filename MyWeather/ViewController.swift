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
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weather1Lbl: UILabel!
    @IBOutlet weak var weather2Lbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windDirLbl: UILabel!
    @IBOutlet weak var rainLbl: UILabel!
    
    var weather: Weather!
    var manager: CLLocationManager!
    var location: Location!
    var latitude:String = ""
    var longitude:String = ""
    var date:String = ""
    let dateFormatter = NSDateFormatter()
    
    
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
        
        
        dispatch_async(dispatch_get_main_queue(),{
            self.locationLbl.text = self.weather.cityName
            let tempF = Int(self.weather.temp)
            self.tempLbl.text = "\(tempF)\u{00B0}F"
            self.weatherIcon.image = UIImage(named: self.weather.icon)
            self.weather1Lbl.text = self.weather.weather1
            self.weather2Lbl.text = self.weather.weather2.capitalizedString
            self.pressureLbl.text = "\(self.weather.pressure) hPa"
            self.humidityLbl.text = "\(self.weather.humidity) %"
            self.windSpeedLbl.text = "\(self.weather.windSpeed) mph"
            self.windDirLbl.text = "\(self.weather.windDir) deg"
            self.rainLbl.text = "\(self.weather.rain) inches"
            
            let date = NSDate(timeIntervalSince1970: self.weather.dateTime)
            self.dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
            self.dateFormatter.timeZone = NSTimeZone()
            let localTime = self.dateFormatter.stringFromDate(date)
            self.timeLbl.text = localTime
        })
        
        
    }
    
        
    
    
}
