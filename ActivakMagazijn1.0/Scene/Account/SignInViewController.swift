//
//  SignInViewController.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 16/09/2022.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    @IBAction func SignInButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        
        auth.signIn(withEmail: Email.text!, password: Password.text!) { (authResult, error )in
            if error != nil {
                
                self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription  ), animated: true, completion: nil )
                
            }
            
            self.performSegue(withIdentifier: "SignInSegue", sender: nil)
        
        
        }
        
        
    }
    
}
 
