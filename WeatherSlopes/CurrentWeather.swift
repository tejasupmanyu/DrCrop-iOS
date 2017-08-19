//
//  CurrentWeather.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 04/06/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemperature : Double!
    
    var cityName : String{
        if _cityName == nil
        {
            _cityName = ""
        }
        return _cityName
    }
    
    var date : String{
        if _date == nil
        {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    var weatherType : String{
        if _weatherType == nil
        {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemperature: Double{
        if _currentTemperature == nil
        {
            _currentTemperature = 0
        }
        return _currentTemperature
    }
    
    func downloadWeatherDetails(completed : @escaping DownloadComplete) {
        // Alamofire Download
        
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? [String : AnyObject]
            {
                if let name = dict["name"] as? String
                {
                    self._cityName = name.capitalized
                    print(self._cityName)
                    
                }
                
                if let weather = dict["weather"] as? [[String: AnyObject]]
                {
                    if let weatherType = weather[0]["main"] as? String
                    {
                        self._weatherType = weatherType.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? [String: AnyObject]
                {
                    if let currentTemperature = main["temp"] as? Double
                    {
                        let kelvinToCelsius =  currentTemperature - 273.1
                        
                        self._currentTemperature = kelvinToCelsius
                        print(self._currentTemperature)
                    }
                }
            }
            
        
        completed()
    }
    
    }
    
}
