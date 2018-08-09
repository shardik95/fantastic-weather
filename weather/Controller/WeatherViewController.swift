//
//  ViewController.swift
//  weather
//
//  Created by Hardik Shah on 8/7/18.
//  Copyright © 2018 Hardik Shah. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, changeCityDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let API_ID = "b82fd2cc1179ec80efbc6636f685ae11"

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let weatherModel = WeatherDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData(url:String, parameters:[String:String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                let weatherData : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherData);
            }
            else{
                self.cityLabel.text = "Connection Issues"
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
        }
        let lat = String(location.coordinate.latitude)
        let lon = String(location.coordinate.longitude)
        
        let params : [String:String] = ["lat":lat,"lon":lon,"appid":API_ID]
        
        getWeatherData(url:WEATHER_URL,parameters: params)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Location Unavailable"
        print(error)
    }
    
    func updateWeatherData(json: JSON){
        
        if let tempResult = json["main"]["temp"].double{
            weatherModel.temperature = Int(tempResult - 273.15)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
            updateUI();
        }
        else{
            cityLabel.text = "Weather Unavailable"
        }
        
    }
    
    func updateUI(){
        cityLabel.text = weatherModel.city
        temperatureLabel.text = "\(weatherModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherModel.weatherIconName)
    }
    
    func userEnteredANewCityName(city: String) {
        print(city)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
    
    

}

