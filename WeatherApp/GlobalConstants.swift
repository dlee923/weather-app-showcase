//
//  GlobalConstants.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/1/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation

typealias downloadComplete = () -> ()

let monthTranslator = [
    
    "01":"January",
    "02":"February",
    "03":"March",
    "04":"April",
    "05":"May",
    "06":"June",
    "07":"July",
    "08":"August",
    "09":"September",
    "10":"October",
    "11":"November",
    "12":"December"

    ]

let WEATHERAPI = "&APPID=adb80f3346788b5ecbf01e17546699d9"
let WEATHERURL = "http://api.openweathermap.org/data/2.5/forecast/city?id="