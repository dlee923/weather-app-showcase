//
//  CityCell.swift
//  WeatherApp
//
//  Created by Daniel Lee on 5/22/16.
//  Copyright © 2016 DLEE. All rights reserved.
//

import Foundation
import UIKit

class CityCell: UICollectionViewCell{

    @IBOutlet weak var cityNameLbl: UILabel!
    
    func configureCell(cellData: CityCellInfo){
        cityNameLbl.text = cellData.cityName
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 7.0
    }
    
}