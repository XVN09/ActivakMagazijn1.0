//
//  AddItemToDatabase.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 15/04/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


class AddItemToDatabase: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker : UIImagePickerController = UIImagePickerController()
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var clickToOpenGalleryButton : UIButton!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var descriptionTextField : UITextField!
    @IBOutlet weak var priceTextfield : UITextField!
    @IBOutlet weak var titleTextField : UITextField!
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
    }
    
    @IBAction func openPhotoLibrary()
       {
           present(imagePicker, animated: true,completion: nil)
    
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           imagePicker.dismiss(animated: true)
           clickToOpenGalleryButton.titleLabel?.isHidden = true
           guard let image = info[.originalImage] as? UIImage else {
               return
           }
           imageView.image = image

       }
    
    func uploadMedia(completion : @escaping(_ url : String?)-> Void){
        let storageRef = Storage.storage(url: "gs://activak-57cf3.appspot.com").reference().child("1QmF9fFlYh5S4TkM_ifD-42i2ABKMC-8pVacw5L1tFGY").child("Producten").child(self.titleTextField.text ?? "")
            if let data = self.imageView.image!.pngData() {
                storageRef.putData(data){(metadata, error) in
                    if error != nil {
                        print("An error occured")
                        completion(nil)
                    }else {
                        storageRef.downloadURL(completion: {(url,error) in
                            print(url?.absoluteString as Any)
                            completion(url?.absoluteString)
                        })
                    }
                }
            }
        }
    
    @IBAction func uploadData()
    {
        uploadMedia() { url in
            guard let url = url else {
                return
            }
            
            let item = [ "Title" : self.titleTextField.text,
                         "Description" : self.descriptionTextField.text,
                         "Price" : self.priceTextfield.text,
                         "Place" : self.titleTextField.text,
                         "Image" : url] as [String: Any]
            
            self.ref.child("1QmF9fFlYh5S4TkM_ifD-42i2ABKMC-8pVacw5L1tFGY").child("Producten").child(self.titleTextField.text ?? "").setValue(item)
            self.present(Service.createAlertController(title: "Succes", message: "Succesvol toegevoegd aan database."  ), animated: true, completion: nil )

            
        }
     //   if ref.child("Info").observeSingleEvent(of: .childAdded, with: <#T##(DataSnapshot) -> Void#>)
            
        //}
    }
}
