//
//  DetailViewController.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 21/05/2023.
//

import Foundation
import UIKit
import FirebaseStorage

class DetailViewController: UIViewController {
    var data: MyData?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var Image : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure your UI elements to display the details
        if let data = data {
            titleLabel.text = data.titleText
            placeLabel.text = data.placeText
            priceLabel.text = data.priceText
            
        }
        let storageRef = Storage.storage().reference(forURL: data!.imgURL)
        
        storageRef.getData(maxSize: 28060876) {(data,error) in
            if let err = error {
                print(err)
            }else {
                if let image = data {
                    let myImage : UIImage! = UIImage(data:image)
                    self.Image.image = myImage
                }
            }
        }
        
    }
}

