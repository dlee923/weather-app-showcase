//
//  MainDay.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/28/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class MainDay {

    private var _cityName: String!
    private var _state: String!
    private var _currentWeatherIcon: String!
    private var _currentWeatherTemp: String!
    private var _currentTime: String!
    private var _currentDayLbl: String!
    private var _currentDayHi: String!
    private var _currentDayLo: String!
    private var _currentDayWind: String!
    
    var cityName: String {
        return _cityName
    }
    var state: String {
        return _state
    }
    var currentWeatherIcon: String {
        return _currentWeatherIcon
    }
    var currentWeatherTemp: String {
        return _currentWeatherTemp
    }
    var currentTime: String {
        return _currentTime
    }
    var currentDayLbl: String {
        return _currentDayLbl
    }
    var currentDayHi: String {
        return _currentDayHi
    }
    var currentDayLo: String {
        return _currentDayLo
    }
    var currentDayWind: String {
        return _currentDayWind
    }
    
    init(cityName: String, state: String, currentWeatherIcon: String, currentWeatherTemp: String, currentTime: String, currentDayLbl: String, currentDayHi: String, currentDayLo: String, currentDayWind: String){
        
        self._cityName = cityName
        self._state = state
        self._currentWeatherIcon = currentWeatherIcon
        self._currentWeatherTemp = currentWeatherTemp
        self._currentTime = currentTime
        self._currentDayLbl = currentDayLbl
        self._currentDayHi = currentDayHi
        self._currentDayLo = currentDayLo
        self._currentDayWind = currentDayWind
    }
    
}