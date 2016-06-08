//
//  Days.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/26/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation

class Days{

    private var _dayXWeatherIcon: String!
    private var _dayXDayLbl: String!
    private var _dayXDayHi: String!
    private var _dayXDayLo: String!
    
    var dayXWeatherIcon: String {
        return _dayXWeatherIcon
    }
    
    var dayXDayLbl: String {
        return _dayXDayLbl
    }

    var dayXDayHi: String {
        return _dayXDayHi
    }
    
    var dayXDayLo: String {
        return _dayXDayLo
    }
    
    init(weatherIcon: String, dayLbl: String, dayHi: String, dayLo: String) {
        self._dayXWeatherIcon = weatherIcon
        self._dayXDayLbl = dayLbl
        self._dayXDayHi = dayHi
        self._dayXDayLo = dayLo
    }
}