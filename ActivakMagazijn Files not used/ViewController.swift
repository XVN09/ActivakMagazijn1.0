//
//  ViewControler.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 22/10/2022.
//

import UIKit
import Firebase
import FirebaseDatabase

//Begining off class
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    //MARK variables
    // For the images
    let BaseURL = URL(string: "https://activak.page.link/")
    let PlaceHolderImage = UIImage(named: "ImgPlaceholder")
    
    // For the database
    let ref = Database.database(url: "https://activak-57cf3-default-rtdb.europe-west1.firebasedatabase.app")
    var refProducts: DatabaseReference!
    
    //outlet tableview
    @IBOutlet weak var tblView: UITableView!
    
    //product list with refrence to the database
    var productsList = [productModel]()
    
    //functions
    //ViewdidloadFunction
    override func viewDidLoad() {
        
        refProducts = ref.reference().child("products")
        refProducts.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                
                for products in snapshot.children.allObjects as![DataSnapshot]{
                    let productObject = products.value as? [String: AnyObject]
                    let productName = productObject?["Name"]
                    let productCategory = productObject?["Category"]
                    let productPrice = productObject?["Price"]
                    let productImageLink = productObject?["imageLink"]
                    
                    let product = productModel(category: productCategory as! String,
                                               name: productName as! String,
                                               price: productPrice as! String,
                                               imageLink: productImageLink as! String)
                    self.productsList.append(product)
                  }
                self.tblView.reloadData()
            }
        })
    }
    
    //function number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: self)
        print("Gelukt")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let destinationVC = segue.destination as! tblViewDetail
            // Do any setup tasks here, such as passing data to the destination view controller
                
            }
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductsTableViewCell
        
        let product: productModel
        
        product = productsList[indexPath.row]
        
        let remoteImageURL = URL(string: product.imageLink)
        
        cell.lblName.text = product.name
        cell.lblPrice.text = product.price
        cell.lblCategory.text = product.category
        cell.imageView?.sd_setImage(with: remoteImageURL,
                                    placeholderImage: PlaceHolderImage,
                                    options: SDWebImageOptions.highPriority,
                                    context: nil,
                                    progress: nil,
                                    completed: { (DownloadedImage, DownloadException, ChacheType, DownloadURL) in
            
            if let DownloadException = DownloadException {
                print("Error downloading image: \(DownloadException.localizedDescription )")
            } else {
                print("Succesfuly downloaded image: \(String(describing: DownloadURL?.absoluteString))")
            }
        })
        
        return cell
    }
}
