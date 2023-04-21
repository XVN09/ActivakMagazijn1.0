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
    
    @IBAction func LogoutButtonPressed(_ sender: Any)
    {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError {
            self.present(Service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
        }
        if Auth.auth().currentUser?.uid == nil {
            self.performSegue(withIdentifier: "BackToHomeSegue", sender: self)
        }
    }
    
    @IBAction func BackToHomeButtong(_ sender: Any){
        self.performSegue(withIdentifier: "BackToHomeSegue", sender: self)
    }
    
    @IBAction func UploadFIlesPressed(_ sender: Any) {
        

    }
}
