//
//  ProfileView.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 15/04/2023.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

class ProfileView : UIViewController {
    
    @IBOutlet weak var UploadFiles: UIButton!
    
    override func viewDidLoad() {
        
        UploadFiles.isHidden = true
        
        if Auth.auth().currentUser?.uid != "utwp4lI84ZQTIvYz4QVEWxWGt3b2"{
            UploadFiles.isHidden = true
        } else {
            UploadFiles.isHidden = false
        }
    }
    
    @IBAction func onLogOutButtonTapped(){
        do{
            try Auth.auth().signOut()
        
        } catch let error as NSError {
            print(error)
        }
        if Auth.auth().currentUser == nil {
            self.performSegue(withIdentifier: "BackToHomeSegue", sender: self)
        }
    }
    
    @IBAction func BackToHomeButton(_ sender: Any){
        self.performSegue(withIdentifier: "BackToHomeSegue", sender: self)
    }
    
    @IBAction func UploadFIlesPressed(_ sender: Any) {
        

    }
}
