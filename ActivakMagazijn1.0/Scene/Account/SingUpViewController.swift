//
//  SingUpViewController.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 16/09/2022.
//

import UIKit
import FirebaseAuth

class SingUpViewController: UIViewController {

    @IBOutlet weak var FullName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func SignUpButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        
        auth.createUser(withEmail: Email.text!, password: Password.text!) { (authResult, error) in
             
            if error != nil {
                
                self.present(Service.createAlertController(title:  "Error", message: error!.localizedDescription ), animated: true, completion: nil )
                
                return
            }
            
            self.performSegue(withIdentifier: "userSignUpSegue", sender: nil)
            
        }
        
    }
    

}
