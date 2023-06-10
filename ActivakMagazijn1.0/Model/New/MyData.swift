//
//  MyData.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 14/04/2023.
//

import Foundation
import UIKit

class MyData {
    
    var imgURL : String
    var titleText : String
    var placeText : String
    var priceText : String
    var descText : String
    var catText : String
    
    init()
        {
            imgURL =  ""
            titleText = ""
            placeText = ""
            priceText = ""
            descText = ""
            catText = ""
        }
    
    func setData(url : String, title : String, place : String, price : String, descripiton : String, category: String) {
        imgURL = url
        titleText = title
        placeText = place
        priceText = price
        descText = descripiton
        catText = category
    }

}
