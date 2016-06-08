//
//  CityCellInfo.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/17/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class CityCellInfo {
    
    private var _cityName: String!
    private var _cityID: String!
    
    var cityName: String {
        return _cityName
    }
    
    var cityID: String {
        return _cityID
    }
    
    init(cityName: String, cityID: String){
        self._cityName = cityName
        self._cityID = cityID
    }
    
}