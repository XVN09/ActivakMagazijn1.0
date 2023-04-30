//
//  DataCell.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 13/04/2023.
//

import Foundation
import UIKit
import FirebaseStorage

class DataCell : UITableViewCell {

    @IBOutlet weak var dataImageView : UIImageView!
    @IBOutlet weak var dataName : UILabel!
    @IBOutlet weak var dataCategory : UILabel!
    @IBOutlet weak var dataPrice : UILabel!
    
    func setValues(data : MyData)
    {
        
        dataName.text = data.titleText
        dataCategory.text = data.categoryText
        dataPrice.text = data.priceText
        
        let storageRef = Storage.storage().reference(forURL: data.imgURL)
        
        storageRef.getData(maxSize: 28060876) {(data,error) in
            if let err = error {
                print(err)
            }else {
                if let image = data {
                    let myImage : UIImage! = UIImage(data:image)
                    self.dataImageView.image = myImage
                }
            }
        }
    }
}
