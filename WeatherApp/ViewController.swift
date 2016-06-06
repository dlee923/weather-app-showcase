//
//  ViewController.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/1/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
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
    var blurAlpha = CGFloat(0.0)
    var blurView: UIVisualEffectView!
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var headerLayer: UIView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundImage = UIImage(named: "nyc")
        let backgroundImgView = UIImageView(image: backgroundImage)
        backgroundImgView.contentMode = UIViewContentMode.ScaleAspectFill
        
        let blurFX = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurView = UIVisualEffectView(effect: blurFX)
        blurView.alpha = blurAlpha
        blurView.frame = backgroundImgView.bounds
        
        backgroundImgView.addSubview(blurView)
        
        self.weatherTableView.backgroundView = backgroundImgView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSavedCity()
        
        updateTime()
        
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        
        downloadData { () -> () in
            print("download completed")
            self.weatherTableView.reloadData()
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
            
            self.weatherTableView.delegate = self
            self.weatherTableView.dataSource = self

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
        print(url)
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
                        var day1Id: String!
                        var day2Id: String!
                        var day3Id: String!
                        var day4Id: String!
                        var day5Id: String!
                        
                        if let date = weatherDays[0]["dt_txt"] as? String{
                            let dateArray = date.componentsSeparatedByString(" ")
                            let dateArray2 = dateArray[0].componentsSeparatedByString("-")
                            
                            originDay = dateArray2[2]
                            print(originDay)
                            let day = NSDateFormatter()
                            day.dateFormat = "dd"
                            day1Id = day.stringFromDate(NSDate(timeInterval: 86400 * 2, sinceDate: NSDate()))
                            day2Id = day.stringFromDate(NSDate(timeInterval: 86400 * 3, sinceDate: NSDate()))
                            day3Id = day.stringFromDate(NSDate(timeInterval: 86400 * 4, sinceDate: NSDate()))
                            day4Id = day.stringFromDate(NSDate(timeInterval: 86400 * 5, sinceDate: NSDate()))
                            day5Id = day.stringFromDate(NSDate(timeInterval: 86400 * 6, sinceDate: NSDate()))
                            
                            print(day1Id)
                            print(day2Id)
                            print(day3Id)
                            print(day4Id)
                            
                        }
                        
                        for var x = 0; x < weatherDays.count; x++ {
                            
                            if let date = weatherDays[x]["dt_txt"] as? String{
                                let dateArray = date.componentsSeparatedByString(" ")
                                let dateArray2 = dateArray[0].componentsSeparatedByString("-")
                                
                                self.month = monthTranslator[dateArray2[1]]
                                self.day = dateArray2[2]
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
                                
                            } else if self.day == day1Id {
                                self.dayArray1.append(newDay)
                                self.day1TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == day2Id {
                                self.dayArray2.append(newDay)
                                self.day2TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == day3Id {
                                self.dayArray3.append(newDay)
                                self.day3TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == day4Id {
                                self.dayArray4.append(newDay)
                                self.day4TempArray.append(newDay.currentTemp)
                                
                            } else if self.day == day5Id {
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
        if rootVC == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let cityVC = storyboard.instantiateViewControllerWithIdentifier("cityVC")
            presentViewController(cityVC, animated: true, completion: nil)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            if let mainWeatherCell = tableView.dequeueReusableCellWithIdentifier("MainCell", forIndexPath: indexPath) as? MainCell {
                
                let mainDayObj = MainDay(cityName: self.passedCity, state: self.dayArray0[0].weatherState2, currentWeatherIcon: self.dayArray0[0].icon, currentWeatherTemp: "\(self.day0TempArray[0])", currentTime: self.time, currentDayLbl: self.days[0], currentDayHi: "\(self.day0Max)", currentDayLo: "\(self.day0Min)", currentDayWind: "\(self.windSpeed)")
                mainWeatherCell.configureCell(mainDayObj)
                
                return mainWeatherCell
            }
        }
        
        if indexPath.row == 1{
            if let dailyWeatherCell = tableView.dequeueReusableCellWithIdentifier("DayCell", forIndexPath: indexPath) as? DayCell {
                
                let day1 = Days(weatherIcon: self.dayArray1[0].icon, dayLbl: self.days[1], dayHi: "\(self.day1Max)", dayLo: "\(self.day1Min)")
                dailyWeatherCell.configureDay1Cell(day1)
                
                let day2 = Days(weatherIcon: self.dayArray2[0].icon, dayLbl: self.days[2], dayHi: "\(self.day2Max)", dayLo: "\(self.day2Min)")
                dailyWeatherCell.configureDay2Cell(day2)

                let day3 = Days(weatherIcon: self.dayArray3[0].icon, dayLbl: self.days[3], dayHi: "\(self.day3Max)", dayLo: "\(self.day3Min)")
                dailyWeatherCell.configureDay3Cell(day3)
                
                let day4 = Days(weatherIcon: self.dayArray4[0].icon, dayLbl: self.days[4], dayHi: "\(self.day4Max)", dayLo: "\(self.day4Min)")
                dailyWeatherCell.configureDay4Cell(day4)
                
                return dailyWeatherCell
            }
        }
        
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let height = scrollView.bounds.size.height
        let position = max(scrollView.contentOffset.y, 0)
        let percent = min(position/height, 0.8)
        self.blurView.alpha = percent
    }
    
    func loadSavedCity(){
        if NSUserDefaults.standardUserDefaults().valueForKey("savedCity") != nil {
            passedCityID = NSUserDefaults.standardUserDefaults().valueForKey("savedCity") as? String
            passedCity = NSUserDefaults.standardUserDefaults().valueForKey("savedCityName") as? String
            print(passedCityID)
        }
    }

}

