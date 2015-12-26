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
    private var _city:String!
    private var _cnt:AnyObject!
    
    var latitude:String{
        return _latitude
    }
    var longitude:String {
        return _longitude
    }
    
    var cnt:AnyObject {
        return _cnt
    }
    
    var city:String {
        if _city == nil {
            _city = "Aargh!"
        }
        return _city
    }

    
    init(latitude:String, longitude:String){
        self._latitude = latitude
        self._longitude = longitude
        
        _locationUrl = "\(URL_BASE)lat=\(self._latitude)&lon=\(self._longitude)&appid=\(APP_ID)"
        
    }
    
    func downloadWeather(latitude:String,longitude:String){
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: self._locationUrl)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error:NSError?) -> Void in
            if let responseData = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    if let dict  = json as? Dictionary<String, AnyObject> {
                        
                        //print(dict)
                        
                        if let cnt = dict["cnt"] as? Int{
                            self._cnt = cnt
                            print(cnt)
                        } else {
                            print("Cnt Not Found")
                        }
                        
                        if let city = dict["city"]!["name"] as? String {
                            self._city = city
                            print(city)
                        }else {
                            print("City not Found")
                        }
                        
                    }
                } catch {
                    print("Request Failed")
                }
            }
            
            }.resume()
    }
}
