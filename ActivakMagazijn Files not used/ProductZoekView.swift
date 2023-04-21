//
//  Zoek.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 01/10/2022.
//

import UIKit
import FirebaseFirestore

class ProductZoekView : UIViewController {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var artiklerArray: [String] = []
    var documents: [DocumentSnapshot] = []
    let backgroundView = UIImageView()
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        loadData()
        
        
        func loadData() {
            db.collection("Products").getDocuments() { (QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents : \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents {
                        let documentID = document.documentID
                        let ProductImageView = document.get("Catagory") as! String
                        let ProductTitleLabel = document.get("Name") as! String
                        print(ProductImageView, ProductTitleLabel, documentID)
                    }
                    self.tabelView.reloadData()
                }
            }
        }
        
        //Background Photo
        backgroundView.image = UIImage(named: "logo")!
        backgroundView.contentMode = .scaleAspectFit
        backgroundView.alpha = 0.5
        
        
        
       // func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // print("Tableview setup \(artiklerArray.count)")
           // return artiklerArray.count
        // }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtiklerCell", for: indexPath) as! ProductsCell
            
            let artikler = artiklerArray[indexPath.row]
            
            print("Array is populated \(artiklerArray)")
            
            return cell
        }
        
    }
}
