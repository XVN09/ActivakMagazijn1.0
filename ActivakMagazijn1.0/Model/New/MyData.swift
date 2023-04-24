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
    static var titleText : String = ""
    var categoryText : String
    var priceText : String
    
    init()
        {
            imgURL = ""
            MyData.titleText = ""
            categoryText = ""
            priceText = ""
        }
    
    func setData(url : String, title : String, category : String, price : String) {
        imgURL = url
        MyData.titleText = title
        categoryText = category
        priceText = price
    }

}
