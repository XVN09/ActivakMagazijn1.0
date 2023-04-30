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
    @IBOutlet weak var titleTextField : UITextField!
    @IBOutlet weak var descriptionTextField : UITextField!
    @IBOutlet weak var priceTextfield : UITextField!
    @IBOutlet weak var categoryTextField : UITextField!
 
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        // Do any additional setup after loading the view.
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
        let storageRef = Storage.storage(url: "gs://activak-57cf3.appspot.com").reference().child("Producten").child(self.titleTextField.text ?? "")
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
                         "Category" : self.categoryTextField.text,
                         "Image" : url] as [String: Any]
            
            self.ref.child("Info").child(self.titleTextField.text ?? "").setValue(item)
            
        }
     //   if ref.child("Info").observeSingleEvent(of: .childAdded, with: <#T##(DataSnapshot) -> Void#>)
            
        //}
    }


    
}
