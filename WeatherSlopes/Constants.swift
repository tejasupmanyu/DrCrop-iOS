//
//  Constants.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 04/06/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATTITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "e725fcbfc3acf7523b50c7aad53d3108"


typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATTITUDE)\(Location.sharedInstance.lattitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.lattitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=e725fcbfc3acf7523b50c7aad53d3108"

