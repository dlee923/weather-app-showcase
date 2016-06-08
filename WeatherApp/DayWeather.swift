//
//  LocationWeather.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/1/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation

class DayWeather{

    private var _currentTemp: Int!
    private var _windSpeed: Int!
    private var _day: String!
    private var _month: String!
    private var _location: String!
    private var _weatherState: String!
    private var _weatherState2: String!
    private var _icon: String!

    var currentTemp: Int {
        return _currentTemp
    }
    
    var windSpeed: Int {
        return _windSpeed
    }
    
    var day: String {
        return _day
    }
    
    var month: String {
        return _month
    }
    
    var location: String {
        return _location
    }
    
    var weatherState: String {
        return _weatherState
    }
    
    var weatherState2: String {
        return _weatherState2
    }
    
    var icon: String! {
        return _icon
    }
    
    
    init(currentTemp: Int, windSpeed: Int, day: String, month: String, location: String, weatherState: String, weatherState2: String, iconName: String){
        self._currentTemp = currentTemp
        self._windSpeed = windSpeed
        self._day = day
        self._month = month
        self._location = location
        self._weatherState = weatherState
        self._weatherState2 = weatherState2
        self._icon = iconName
    }

}