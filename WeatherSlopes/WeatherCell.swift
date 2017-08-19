//
//  WeatherCell.swift
//  WeatherSlopes
//
//  Created by Tejas Upmanyu on 05/06/17.
//  Copyright © 2017 VisionArray. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var dayOfWeek: UILabel!
    
    func configureCell(forecast : Forecast)
    {
        highTemp.text = "\(forecast.highTemp)"
        lowTemp.text = "\(forecast.lowTemp)"
        dayOfWeek.text = forecast.date
        weatherType.text = forecast.weatherType
        weatherImage.image = UIImage(named: "Rain")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
