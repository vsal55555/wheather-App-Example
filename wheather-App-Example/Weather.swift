//
//  Weather.swift
//  wheather-App-Example
//
//  Created by BSAL-MAC on 4/18/20.
//  Copyright © 2020 BSAL-MAC. All rights reserved.
//

import Foundation

struct Weather{
    let cityName: String
    let temp: Double
    let description: String
    let icon: String
    
    var tempC: Double{
        get{
            return temp - 273.15
        }
        
    }
    
    init(cityName: String, temp: Double, description: String, icon: String) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
    }
}
