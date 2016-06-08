//
//  DayCell.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/26/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class DayCell: UITableViewCell{

    @IBOutlet weak var day1WeatherIcon: UIImageView!
    @IBOutlet weak var day1DayLbl: UILabel!
    @IBOutlet weak var day1DayHi: UILabel!
    @IBOutlet weak var day1DayLo: UILabel!
    
    @IBOutlet weak var day2WeatherIcon: UIImageView!
    @IBOutlet weak var day2DayLbl: UILabel!
    @IBOutlet weak var day2DayHi: UILabel!
    @IBOutlet weak var day2DayLo: UILabel!
    
    @IBOutlet weak var day3WeatherIcon: UIImageView!
    @IBOutlet weak var day3DayLbl: UILabel!
    @IBOutlet weak var day3DayHi: UILabel!
    @IBOutlet weak var day3DayLo: UILabel!
    
    @IBOutlet weak var day4WeatherIcon: UIImageView!
    @IBOutlet weak var day4DayLbl: UILabel!
    @IBOutlet weak var day4DayHi: UILabel!
    @IBOutlet weak var day4DayLo: UILabel!
    
    func configureDay1Cell(daysObj: Days){
        day1WeatherIcon.image = UIImage(named: daysObj.dayXWeatherIcon)
        day1DayLbl.text = daysObj.dayXDayLbl
        day1DayHi.text = daysObj.dayXDayHi
        day1DayLo.text = daysObj.dayXDayLo
    }
    
    func configureDay2Cell(daysObj: Days){
        day2WeatherIcon.image = UIImage(named: daysObj.dayXWeatherIcon)
        day2DayLbl.text = daysObj.dayXDayLbl
        day2DayHi.text = daysObj.dayXDayHi
        day2DayLo.text = daysObj.dayXDayLo
    }
    
    func configureDay3Cell(daysObj: Days){
        day3WeatherIcon.image = UIImage(named: daysObj.dayXWeatherIcon)
        day3DayLbl.text = daysObj.dayXDayLbl
        day3DayHi.text = daysObj.dayXDayHi
        day3DayLo.text = daysObj.dayXDayLo
    }
    
    func configureDay4Cell(daysObj: Days){
        day4WeatherIcon.image = UIImage(named: daysObj.dayXWeatherIcon)
        day4DayLbl.text = daysObj.dayXDayLbl
        day4DayHi.text = daysObj.dayXDayHi
        day4DayLo.text = daysObj.dayXDayLo
    }
}