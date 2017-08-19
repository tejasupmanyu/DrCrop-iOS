//
//  ViewController.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 03/06/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    
    @IBOutlet weak var weatherType_label: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var place_label: UILabel!
    
    @IBOutlet weak var temperature_label: UILabel!
    
    @IBOutlet weak var date_label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather : CurrentWeather!
    var forecast : Forecast!
    
    var forecasts = [Forecast]()
    let locationManager = CLLocationManager()
    
    var location : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        currentWeather = CurrentWeather()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            location = locationManager.location
            Location.sharedInstance.lattitude = location.coordinate.latitude
            Location.sharedInstance.longitude = location.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
                
            }

            print(location)
            
        }
        else
        {
            locationManager.requestAlwaysAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(complete : @escaping DownloadComplete)
    {
        // Download Forecast
        
        
        Alamofire.request(FORECAST_URL).responseJSON { (response) in
            
            let result = response.result
            
            if let dict = result.value as? [String : AnyObject]
            {
                if let list = dict["list"] as? [[String: AnyObject]]
                {
                    for obj in list
                    {
                        print(obj)
                        let forecast = Forecast(weatherDict : obj)
                        self.forecasts.append(forecast)
                        
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            complete()
            
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell
        {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else
        {
            return WeatherCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func updateMainUI() {
        date_label.text = currentWeather.date
        
        place_label.text = currentWeather.cityName
        weatherType_label.text = currentWeather.weatherType
        var temp = String(format: "%.1f", currentWeather.currentTemperature)
        temperature_label.text = "\(temp)°C"
        weatherImage.image = UIImage(named:"Clear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

