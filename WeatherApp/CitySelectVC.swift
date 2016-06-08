//
//  CitySelectVC.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/17/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class CitySelectVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityCollectionTbl.delegate = self
        cityCollectionTbl.dataSource = self
        citySearchBar.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        parseJSONFile()
    }
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityCollectionTbl: UICollectionView!
    
    var cityCell = [CityCellInfo]()
    var filteredCityCell = [CityCellInfo]()
    var inSearchMode = false
    var cityID: String!
    var cityName: String!
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredCityCell.count
        } else {
            return cityCell.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CityCell", forIndexPath: indexPath) as? CityCell{
            if inSearchMode {
                cell.configureCell(filteredCityCell[indexPath.row])
            } else {
                cell.configureCell(cityCell[indexPath.row])
            }
            
            return cell
        
        } else {
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 110, height: 40)
    }
    
    func parseJSONFile(){
        let path = NSBundle.mainBundle().pathForResource("cityListUS", ofType: "json")!
        let jsonFile = NSData(contentsOfFile: path)!
        
        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(jsonFile, options: .AllowFragments)
            if let cityDict = jsonData as? [Dictionary<String, AnyObject>] {
                
                for var x = 0; x < cityDict.count ; x++ {
                
                    if let cityID = jsonData[x]["_id"]!{
                        self.cityID = "\(cityID)"
                    }
                    
                    if let cityName = jsonData[x]["name"]!{
                        self.cityName = "\(cityName.uppercaseString)"
                    }
                    
                    let newCityInfo = CityCellInfo(cityName: cityName, cityID: cityID)
                    cityCell.append(newCityInfo)
                    
                }
            }
        } catch {
            print("Error")
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if citySearchBar.text == nil || citySearchBar.text == ""{
            inSearchMode = false
            cityCollectionTbl.reloadData()
        } else {
            inSearchMode = true
            let upperCaseSearch = citySearchBar.text!.uppercaseString
            filteredCityCell = cityCell.filter({$0.cityName.rangeOfString(upperCaseSearch) != nil})
            cityCollectionTbl.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cityInfo: CityCellInfo
        
        if inSearchMode {
            cityInfo = filteredCityCell[indexPath.row]
        } else {
            cityInfo = cityCell[indexPath.row]
        }
        
        performSegueWithIdentifier("ShowWeather", sender: cityInfo)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowWeather" {
            if let weatherScreen = segue.destinationViewController as? ViewController {
                if let passedCityObj = sender as? CityCellInfo{
                    weatherScreen.passedCity = passedCityObj.cityName
                    weatherScreen.passedCityID = passedCityObj.cityID
                    
                    NSUserDefaults.standardUserDefaults().setValue(passedCityObj.cityID, forKey: "savedCity")
                    NSUserDefaults.standardUserDefaults().setValue(passedCityObj.cityName, forKey: "savedCityName")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    rootVC = true
                    NSUserDefaults.standardUserDefaults().setValue(rootVC, forKey: "saveKey")
                }
            }
        }
    }
    
}