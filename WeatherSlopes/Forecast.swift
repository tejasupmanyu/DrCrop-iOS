//
//  Forecast.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 04/06/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    
    var _date : String!
    var _lowTemp : String!
    var _weatherType : String!
    var _highTemp : String!
    
    var lowTemp : String{
        if _lowTemp == nil
        {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    var date : String{
        if _date == nil
        {
            _date = ""
        }
    
        return _date
    }
    var weatherType : String{
        if _weatherType == nil
        {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String{
        if _highTemp == nil
        {
            _highTemp = ""
        }
        return _highTemp
    }
    
    
    init(weatherDict : [String: AnyObject]) {
        
        if let temp = weatherDict["temp"] as? [String: AnyObject]
        {
            if let min = temp["min"] as? Double
            {
                self._lowTemp = String(format: "%.1f", min - 273.1)
                //self._lowTemp = "\(min - 273.1)"
                print(self._lowTemp)
            }
            
            if let max = temp["max"] as? Double
            {
                self._highTemp = String(format: "%.1f", max - 273.1)
                //self._highTemp = "\(max - 273.1)"
                 print(self._highTemp)
            }
        }
        
        if let weather = weatherDict["weather"] as? [[String : AnyObject]]
        {
            if let main = weather[0]["main"] as? String
            {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double
        {
            let dateCovertedFromUNIX = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = dateCovertedFromUNIX.dayOfWeek()
            
        }
    }
}

extension Date {
    
    func dayOfWeek() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
