//
//  WeatherService.swift
//  wheather-App-Example
//
//  Created by BSAL-MAC on 4/17/20.
//  Copyright © 2020 BSAL-MAC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
//defining the WSD type with help of protocol
protocol WeatherServiceDelegate{
    //you can also define variable here
    func setWeather(weather: Weather)
}
class WeatherService: UIViewController{
    var delegate: WeatherServiceDelegate?
    //you call getweather and you will pass in city
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getWeather(city: String){
        //request weather data
        //wait..
        //process data
        //let weather = Weather(cityName: "city", temp: 237.12, description: "Very nice day")
        //print("the weather service is \(city)")
        //if delegate != nil{ //in that we can call set methods safely

    //  delegate?.setWeather(weather: weather)
    
        DispatchQueue.main.async {
            let cityEscaped = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=60b73c37b29edd2005a772c857e6f701")
            
            Alamofire.request(url!, method: .get, parameters: nil, headers: nil).responseJSON { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    //  let data = json["tested_total"].intValue
                    let lon = json["coord"]["lon"].doubleValue
                    let lat = json["coord"]["lat"].doubleValue
                    let temp = json["main"]["temp"].doubleValue
                    let name = json["name"].stringValue
                    let desc = json["weather"][0]["description"].stringValue
                    let icon = json["weather"][0]["icon"].stringValue
                    let weather = Weather(cityName: name, temp: temp, description: desc, icon: icon)
                    if self.delegate != nil {
                        self.delegate?.setWeather(weather: weather)
                    }
                    print("Lat: \(lat) Lon: \(lon) temp: \(temp)")
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
            
        }
    }
    
    }
    

