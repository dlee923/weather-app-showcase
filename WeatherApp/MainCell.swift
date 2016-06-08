//
//  MainCell.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/26/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class MainCell: UITableViewCell{

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var State: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherTemp: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var currentDayLbl: UILabel!
    @IBOutlet weak var currentDayHi: UILabel!
    @IBOutlet weak var currentDayLo: UILabel!
    @IBOutlet weak var currentDayWind: UILabel!
    
    func configureCell(todaysWeather: MainDay){
        self.cityName.text = todaysWeather.cityName
        self.State.text = todaysWeather.state
        self.currentWeatherIcon.image = UIImage(named: todaysWeather.currentWeatherIcon)
        self.currentWeatherTemp.text = "\(todaysWeather.currentWeatherTemp)°"
        self.currentDayWind.text = "\(todaysWeather.currentDayWind) MPH"
        self.currentDayHi.text = todaysWeather.currentDayHi
        self.currentDayLo.text = todaysWeather.currentDayLo
        self.currentDayLbl.text = todaysWeather.currentDayLbl
        self.currentTime.text = todaysWeather.currentTime
    }
}