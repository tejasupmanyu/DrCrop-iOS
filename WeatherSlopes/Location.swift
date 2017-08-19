//
//  Location.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 06/06/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    
    private init() {}
    
    var lattitude : Double!
    var longitude : Double!
}

