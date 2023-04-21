//
//  Service.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 17/09/2022.
//

import UIKit

class Service {
    
    static func createAlertController(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert )
        
        let okAction = UIAlertAction(title:  "Ok", style: .default) { (action) in
            alert.dismiss(animated: false)
        }
       
        alert.addAction(okAction)
        
        return alert 
    
    
    }
    
}
