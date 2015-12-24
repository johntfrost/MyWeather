//
//  ViewController.swift
//  MyWeather
//
//  Created by John Frost on 12/24/15.
//  Copyright © 2015 Pair-A-Dice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather: Weather!
    
    var lat:String = "35"
    var lon:String = "-84"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(lat)
        print(lon)
        
        weather.downloadWeather(lat, longitude: lon)
        
   
        
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

