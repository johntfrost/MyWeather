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
    let URL_BASE = "http://api.openweathermap.org/data/2.5/forecast?"
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
    private var _dateTime:String!
    private var _icon:String!
    
    

    var latitude:String{
        return _latitude
        }
    var longitude:String {
        return _longitude
        }
    
    var cityName:String {
        return _cityName
        }
    
    var temp:Double{
        return _temp
        }
    
    var pressure:Double{
        return _pressure
    }
    
    var humidity:Int{
        return _humidity
    }
    var weather1:String{
        return _weather1
    }
    var weather2:String{
        return _weather2
    }
    
    var cloudCover:Int{
        return _cloudCover
    }
    
    var windSpeed:Double{
        return _windSpeed
    }
    
    var windDir:Double{
        return _windDir
    }
    
    var rain:Double{
        return _rain
    }
    
    var dateTime:String{
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
                        
                        if let city = weatherData["city"] as? Dictionary<String, AnyObject> {
                            if let name = city["name"] as? String{
                            self._cityName = name
                            }
                        }
                        
                        if let list = weatherData["list"]![0] as? Dictionary<String, AnyObject> {
                            
                            if let main = list["main"] as? Dictionary<String, AnyObject>{
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
                            
                            if let weatherArr = list["weather"]![0] as? Dictionary<String, AnyObject> {
                    
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
                            
                            if let clouds = list["clouds"] as? Dictionary<String, Int>{
                                if let cloudCover = clouds["all"]{
                                    self._cloudCover = cloudCover
                                }
                            }
                            
                            if let wind = list["wind"] as? Dictionary<String, AnyObject>{
                                if let windSpeed = wind["speed"] as? Double{
                                    self._windSpeed = windSpeed
                                }
                                
                                if let windDir = wind["deg"] as? Double {
                                    self._windDir = windDir
                                }
                            }
                            
                            if let rainData = list["rain"] as? Dictionary<String, AnyObject>{
                                if let rain = rainData["3h"] as? Double {
                                    self._rain = rain * 0.039
                                }
                            }
                            
                            if let dateTime = list["dt_txt"] as? String{
                                self._dateTime = dateTime
                            }
                            
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