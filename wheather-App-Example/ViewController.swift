//
//  ViewController.swift
//  wheather-App-Example
//
//  Created by BSAL-MAC on 4/17/20.
//  Copyright © 2020 BSAL-MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate{
    //vc has copy of weatherService class
    let weatherService = WeatherService()

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconimage: UIImageView!
    @IBAction func setCityTapped(_ sender: Any) {
        print("city buttom tapped")
        openCityAlert()
    }
    
    func openCityAlert(){
        //creating alert controller
        let alert = UIAlertController(title: "City", message: "Enter City Name", preferredStyle: .alert)
        //create alert action cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //attach alert action cancel to controller
        alert.addAction(cancel)
        //presented the controller here
        //create ok action
        let ok = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            print("OK")
            let textField = alert.textFields?[0]
            print(textField?.text!)
            self.cityLabel.text = textField?.text!
            let cityName = textField?.text!
            self.weatherService.getWeather(city: cityName!)
        }
        alert.addAction(ok)
        //add text field
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "City Name"
        }
        //present alert controller
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: WEATHER SERVICE DELEGATE
    func setWeather(weather: Weather) {
        print("***set weather")
        print("city: \(weather.cityName) temp: \(weather.temp) desc: \(weather.description)")
        //cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.tempC)" + "°"
        descriptionLabel.text = weather.description
        iconimage.image = UIImage(named: weather.icon)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //delegate property of WS is instance of VC
 //our ws instance we gonna assign its deleagte property to this self(vc)
        self.weatherService.delegate = self as? WeatherServiceDelegate
        
    }


}
