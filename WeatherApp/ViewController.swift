//
//  ViewController.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/1/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var State: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherTemp: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var currentDayLbl: UILabel!
    @IBOutlet weak var currentDayHi: UILabel!
    @IBOutlet weak var currentDayLo: UILabel!
    @IBOutlet weak var currentDayWind: UILabel!
    
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
    
    var Day: DayWeather!
    
    var currentTemp: Int!
    var windSpeed: Int!
    var day: String!
    var month: String!
    var location: String!
    var weatherState: String!
    var weatherState2: String!
    var icon: String!
    var passedCity: String!
    var passedCityID: String!
    var time: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateTime()
        
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        
        downloadData { () -> () in
            print("download completed")
            
            self.day1Max = self.day1TempArray.maxElement()
            self.day2Max = self.day2TempArray.maxElement()
            self.day3Max = self.day3TempArray.maxElement()
            self.day4Max = self.day4TempArray.maxElement()
            self.day5Max = self.day5TempArray.maxElement()
            self.day0Max = self.day0TempArray.maxElement()
            
            self.day1Min = self.day1TempArray.minElement()
            self.day2Min = self.day2TempArray.minElement()
            self.day3Min = self.day3TempArray.minElement()
            self.day4Min = self.day4TempArray.minElement()
            self.day5Min = self.day5TempArray.minElement()
            self.day0Min = self.day0TempArray.minElement()
            
//            self.findAverageInArray(self.day1TempArray)
//            self.findAverageInArray(self.day2TempArray)
//            self.findAverageInArray(self.day3TempArray)
//            self.findAverageInArray(self.day4TempArray)
//            self.findAverageInArray(self.day5TempArray)
//            self.findAverageInArray(self.day0TempArray)
            
            self.cityName.text = self.passedCity
            self.State.text = self.dayArray0[0].weatherState2
            self.currentWeatherIcon.image = UIImage(named: "\(self.dayArray0[0].icon)")!
            self.currentWeatherTemp.text = "\(self.day0TempArray[0])"
            print(self.day0TempArray[0])
            self.currentDayLbl.text = self.days[0]
            self.currentDayHi.text = "\(self.day0Max)"
            self.currentDayLo.text = "\(self.day0Min)"
            self.currentDayWind.text = "\(self.windSpeed) MPH"
            
            self.day1WeatherIcon.image = UIImage(named: "\(self.dayArray1[0].icon)")
            self.day1DayLbl.text = self.days[1]
            self.day1DayHi.text = "\(self.day1Max)"
            self.day1DayLo.text = "\(self.day1Min)"
            
//            self.day2WeatherIcon.image = UIImage(named: "\(self.dayArray2[0].icon)")
            self.day2DayLbl.text = self.days[2]
            self.day2DayHi.text = "\(self.day2Max)"
            self.day2DayLo.text = "\(self.day2Min)"
//
//            self.day3WeatherIcon.image = UIImage(named: "\(self.dayArray3[0].icon)")
//            self.day3DayLbl.text = self.days[3]
//            self.day3DayHi.text = "\(self.day3Max)"
//            self.day3DayLo.text = "\(self.day3Min)"
//            
//            self.day4WeatherIcon.image = UIImage(named: "\(self.dayArray4[0].icon)")
//            self.day4DayLbl.text = self.days[4]
//            self.day4DayHi.text = "\(self.day4Max)"
//            self.day4DayLo.text = "\(self.day4Min)"
        }
    }
    
    var dayArray0 = [DayWeather]()
    var day0TempArray = [Int]()
    var day0Max: Int!
    var day0Min: Int!
    
    var dayArray2 = [DayWeather]()
    var day2TempArray = [Int]()
    var day2Max: Int!
    var day2Min: Int!
    
    var dayArray3 = [DayWeather]()
    var day3TempArray = [Int]()
    var day3Max: Int!
    var day3Min: Int!
    
    var dayArray4 = [DayWeather]()
    var day4TempArray = [Int]()
    var day4Max: Int!
    var day4Min: Int!
    
    var dayArray5 = [DayWeather]()
    var day5TempArray = [Int]()
    var day5Max: Int!
    var day5Min: Int!
    
    var dayArray1 = [DayWeather]()
    var day1TempArray = [Int]()
    var day1Max: Int!
    var day1Min: Int!
    
    var dailyWeatherAvg = [Int]()
    var days = [String]()
    
    private var _celsius: Int!
    private var _farenheit: Int!
    
    func convertKelvinToCelsius(kelvin: Int) -> Int{
        _celsius = kelvin - 273
        return _celsius
    }
    
    func convertCelsiusToFarenheit(convertKelvinToCelsius: (Int) -> Int, kelvin:Int) -> Int{
        _farenheit = Int((Double(convertKelvinToCelsius(kelvin)) * 1.8) + 32.0)
        return _farenheit
    }
    
    func convertMetersPerSecToMPH(metersSec: Double) -> Int{
        let mph = Int(metersSec * 2.237)
        return mph
    }
    
    func downloadData(completed: downloadComplete){
        let url = "\(WEATHERURL)\(passedCityID)\(WEATHERAPI)"
        let urlString = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(urlString) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                if let dict = json as? Dictionary<String, AnyObject>{
                    if let cityName = dict["city"]!["name"]!! as? String{
                        self.location = cityName
                    }
                    
                    if let weatherDays = dict["list"] as? [Dictionary<String, AnyObject>]{
                        
                        var originDay: String!
                        
                        if let date = weatherDays[0]["dt_txt"] as? String{
                            let dateArray = date.componentsSeparatedByString(" ")
                            let dateArray2 = dateArray[0].componentsSeparatedByString("-")
                            
                            originDay = dateArray2[2]
                        }
                        
                        for var x = 0; x < weatherDays.count; x++ {
                            
                            if let date = weatherDays[x]["dt_txt"] as? String{
                                let dateArray = date.componentsSeparatedByString(" ")
                                let dateArray2 = dateArray[0].componentsSeparatedByString("-")
                                
                                self.month = monthTranslator[dateArray2[1]]
                                self.day = dateArray2[2]
                                print(self.day) 
                            }
                            
                            if let weatherTemp = weatherDays[x]["main"]!["temp"]!! as? Double{
                                self.currentTemp = self.convertCelsiusToFarenheit(self.convertKelvinToCelsius, kelvin: Int(weatherTemp))
                            }
                            
                            if let weatherWind = weatherDays[x]["wind"]!["speed"] as? Double{
                                let weatherWindMPH = self.convertMetersPerSecToMPH(weatherWind)
                                self.windSpeed = weatherWindMPH
                            }
                            
                            if let weatherDict = weatherDays[x]["weather"] as? [Dictionary<String, AnyObject>]{
                                if let weatherStatus = weatherDict[0]["main"] as? String, let weatherStatusDet = weatherDict[0]["description"] as? String, let iconID = weatherDict[0]["icon"] as? String{
                                    self.weatherState = weatherStatus
                                    self.weatherState2 = weatherStatusDet
                                    
                                    self.icon = iconID
                                }
                            }
                            
                            let newDay = DayWeather(currentTemp: self.currentTemp, windSpeed: self.windSpeed, day: self.day, month: self.month, location: self.location, weatherState: self.weatherState, weatherState2: self.weatherState2, iconName: self.icon)
                            
                            if self.day == originDay {
                                self.dayArray0.append(newDay)
                                self.day0TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == "\((Int(originDay)! + 1))"{
                                self.dayArray1.append(newDay)
                                self.day1TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == "\((Int(originDay)! + 2))"{
                                self.dayArray2.append(newDay)
                                self.day2TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == "\((Int(originDay)! + 3))"{
                                self.dayArray3.append(newDay)
                                self.day3TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == "\((Int(originDay)! + 4))"{
                                self.dayArray4.append(newDay)
                                self.day4TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == "\((Int(originDay)! + 5))"{
                                self.dayArray5.append(newDay)
                                self.day5TempArray.append(newDay.currentTemp)
                            }
                        }
                    }
                }
                completed()
            }catch let err as NSError{
                print(err.debugDescription)
            }
                
            })
        }.resume()
    }
    
    func findAverageInArray(intArray: [Int]){
        
        var total = 0
        
        for number in intArray {
            total += number
        }
        
        let avg = total / intArray.count
        dailyWeatherAvg.append(avg)
    }
    
    func updateTime(){
        let time = NSDateFormatter()
        time.dateFormat = "hh:mm a"
        let timeString = time.stringFromDate(NSDate())
        self.time = timeString
        self.currentTime.text = self.time
        
        let shortDate = NSDateFormatter()
        shortDate.dateFormat = "EEE"
        let longDate = NSDateFormatter()
        longDate.dateFormat = "EEEE"
        
        let dateString1 = longDate.stringFromDate(NSDate()).uppercaseString
        days.append(dateString1)
        
        for var x = 1.0; x < 5.0 ; x++ {
            let dayName = shortDate.stringFromDate(NSDate(timeInterval: (86400 * x), sinceDate: NSDate())).uppercaseString
            days.append(dayName)
        }
        
    }

    @IBAction func selectCityBtnPressed(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

