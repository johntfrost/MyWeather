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
    
    private var _latitude:String!
    private var _longitude:String!
    private var _locationUrl:String!
    private var _cityName:String!
    private var _temp:Double!
    private var _pressure:Double!
    private var _humidity:Int!
    
    
    
    var latitude:String{
        return _latitude
        }
    var longitude:String {
        return _longitude
        }
    
    var cityName:String {
        if _cityName == nil {
            _cityName = "Aargh!"
        }
        return _cityName
        }
    
    var temp:Double{
        if _temp == nil{
            print("Temp Failed")
        }
        return _temp
        }
    
    var pressure:Double{
        if _pressure == nil{
            print("Pressure Failed")
        }
        return _pressure
    }
    
    var humidity:Int{
        if _humidity == nil{
            print("Humididty Failed")
        }
        return _humidity
    }

    

    
    init(latitude:String, longitude:String){
        self._latitude = latitude
        self._longitude = longitude
        
        _locationUrl = "\(URL_BASE)lat=\(self._latitude)&lon=\(self._longitude)&appid=\(APP_ID)"
        
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