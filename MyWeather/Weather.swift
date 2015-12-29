//
//  Weather.swift
//  MyWeather
//
//  Created by John Frost on 12/24/15.
//  Copyright © 2015 Pair-A-Dice. All rights reserved.
//

import Foundation

class Weather {
    
    let APP_ID = "971fe1f014c02772e6fc927c07b46aa9"
    let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?"
    let IMP = "&units=imperial"
    
    private var _latitude:String!
    private var _longitude:String!
    private var _locationUrl:String!
    private var _cityName:String!
    private var _temp:Double!           //Farenheight
    private var _pressure:Double!       //hPa
    private var _humidity:Int!          // %
    private var _weather1:String!
    private var _weather2:String!
    private var _cloudCover:Int!        // %
    private var _windSpeed:Double!      //miles/hour
    private var _windDir:Double!        //degrees
    private var _rain:Double!           //converted to inches from MM
    private var _dateTime:Double!
    private var _icon:String!
    
    

    var latitude:String{
        if _latitude == nil{
            _latitude = ""
        }
        return _latitude
        }
    var longitude:String {
        if _longitude == nil{
            _longitude = ""
        }
        return _longitude
        }
    
    var cityName:String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
        }
    
    var temp:Double{
        if _temp == nil {
            _temp = 0
        }
        return _temp
        }
    
    var pressure:Double{
        if _pressure == nil{
            _pressure = 0
        }
        return _pressure
    }
    
    var humidity:Int{
        if _pressure == nil{
            _pressure = 0
        }
        return _humidity
    }
    var weather1:String{
        if _weather1 == nil{
            _weather1 = ""
        }
        return _weather1
    }
    var weather2:String{
        if _weather2 == nil{
            _weather2 = ""
        }
        return _weather2
    }
    
    var cloudCover:Int{
        if _cloudCover == nil{
            _cloudCover = 0
        }
        return _cloudCover
    }
    
    var windSpeed:Double{
        if _windSpeed == nil{
            _windSpeed = 0
        }
        return _windSpeed
    }
    
    var windDir:Double{
        if _windDir == nil{
            _windDir = 0
        }
        return _windDir
    }
    
    var rain:Double{
        if _rain == nil {
            _rain = 0
        }
        return _rain
    }
    
    var dateTime:Double{
        return _dateTime
    }
    
    var icon:String{
        return _icon
    }
    
    
    


    

    
    init(latitude:String, longitude:String){
        self._latitude = latitude
        self._longitude = longitude
        
        _locationUrl = "\(URL_BASE)lat=\(self._latitude)&lon=\(self._longitude)\(IMP)&appid=\(APP_ID)"
        
    }
    
    func downloadWeather(latitude:String,longitude:String, completed: DownloadComplete){
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: self._locationUrl)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void in
            if let responseData = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    if let weatherData  = json as? Dictionary<String, AnyObject> {
                        
                        //print(weatherData)
                        
                        if let city = weatherData["name"] as? String {
                            self._cityName = city
                            
                        }
                        
                        
                            if let main = weatherData["main"] as? Dictionary<String, AnyObject>{
                                if let temp = main["temp"] as? Double{
                                    self._temp = temp
                                }
                                if let pressure = main["pressure"] as? Double{
                                    self._pressure = pressure
                                }
                                
                                if let humidity = main["humidity"] as? Int{
                                    self._humidity = humidity
                                }
                            }
                            
                            if let weatherArr = weatherData["weather"]![0] as? Dictionary<String, AnyObject> {
                    
                                if let weather1 = weatherArr["main"] as? String{
                                    self._weather1 = weather1
                                }
                                
                                if let weather2 = weatherArr["description"] as? String{
                                    self._weather2 = weather2
                                }
                                
                                if let icon = weatherArr["icon"] as? String {
                                    self._icon = icon
                                }
                            }
                            
                            if let clouds = weatherData["clouds"] as? Dictionary<String, Int>{
                                if let cloudCover = clouds["all"]{
                                    self._cloudCover = cloudCover
                                }
                            }
                            
                            if let wind = weatherData["wind"] as? Dictionary<String, AnyObject>{
                                if let windSpeed = wind["speed"] as? Double{
                                    self._windSpeed = windSpeed
                                }
                                
                                if let windDir = wind["deg"] as? Double {
                                    self._windDir = windDir
                                }
                            }
                            
                            if let rainData = weatherData["rain"] as? Dictionary<String, AnyObject>{
                                if let rain = rainData["3h"] as? Double {
                                    self._rain = rain * 0.039
                                }
                            }
                            
                            if let dateTime = weatherData["dt"] as? Double{
                                self._dateTime = dateTime
                            }
                            
                        
                    }
                        
                    completed()
                        
                } catch {
                    print("Request Failed")
                }
            }
            
            }.resume()
    }

}