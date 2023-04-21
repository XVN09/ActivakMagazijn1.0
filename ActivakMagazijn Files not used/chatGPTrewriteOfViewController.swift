import Foundation
import UIKit
import FirebaseDatabase
import SDWebImage


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    var productImages: [ProductImage] = []
    let BaseURL = URL(string: "https://activak.page.link")
    let PlaceHolderImage = UIImage(named: "ImgPlaceholder")
    
    let ref = Database.database().reference()
    var refProducts: DatabaseReference!
    
    @IBOutlet weak var tblView: UITableView!
    
    var productsList = [productModel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filtredProducts = [productModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refProducts = ref.child("products")
        refProducts.observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.productsList.removeAll()
                for products in snapshot.children.allObjects as! [DataSnapshot] {
                    let productObject = products.value as? [String: AnyObject]
                    let productName = productObject?["Name"] as? String ?? ""
                    let productCategory = productObject?["Category"] as? String ?? ""
                    let productPrice = productObject?["Price"] as? String ?? ""
                    
                    let product = productModel(category: productCategory, name: productName, price: productPrice)
                    self.productsList.append(product)
                }
                self.tblView.reloadData()
            }
        }
        
        configureTable()
        tblView.delegate = self
        tblView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureTable() {
        productImages.append(ProductImage(imageName: "Voetbal"))
        productImages.append(ProductImage(imageName: "Hoelahoep"))
        productImages.append(ProductImage(imageName: "Gekleurdkrijt"))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filtredProducts.count : productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with

                                                 //functions
                                                 //ViewdidloadFunction
                                                 func viewDidLoad() {
                                                     super.viewDidLoad()
                                                     configureTable()
                                                     
                                                     refProducts = Database.database().reference().child("products")
                                                     refProducts.observe(.value, with: { snapshot in
                                                         self.productsList.removeAll()
                                                         if let productDicts = snapshot.value as? [String: [String: Any]] {
                                                             for productDict in productDicts.values {
                                                                 if let name = productDict["Name"] as? String,
                                                                    let category = productDict["Category"] as? String,
                                                                    let price = productDict["Price"] as? String {
                                                                     let product = Product(name: name, category: category, price: price)
                                                                     self.productsList.append(product)
                                                                 }
                                                             }
                                                             self.tblView.reloadData()
                                                         }
                                                     })
                                                     
                                                     // setup search bar
                                                     searchController.searchResultsUpdater = self
                                                     searchController.obscuresBackgroundDuringPresentation = false
                                                     searchController.searchBar.placeholder = "Search Products"
                                                     navigationItem.searchController = searchController
                                                     definesPresentationContext = true
                                                 }

                                                 // MARK: - Table view data source

                                                 func numberOfSections(in tableView: UITableView) -> Int {
                                                     return 1
                                                 }

                                                 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                                                     if isFiltering() {
                                                         return filtredProducts.count
                                                     }
                                                     return productsList.count
                                                 }

                                                 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                                                     let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductsTableViewCell
                                                     let product: productModel
                                                     if isFiltering() {
                                                         product = filtredProducts[indexPath.row]
                                                     } else {
                                                         product = productsList[indexPath.row]
                                                     }
                                                     cell.lblName.text = product.name
                                                     cell.lblPrice.text = product.price
                                                     cell.lblCategory.text = product.category
                                                     
                                                     let image = productImages[indexPath.row % productImages.count].imageName
            let imageURL = (BaseURL?.appendingPathComponent(image).absoluteString)!
                                                     cell.productImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: PlaceHolderImage)
                                                     
                                                     return cell
                                                 }

                                                 // MARK: - Search bar

                                                 func updateSearchResults(for searchController: UISearchController) {
                                                     let searchBar = searchController.searchBar
                                                     filterContentForSearchText(searchBar.text!)
                                                 }

                                                 func searchBarIsEmpty() -> Bool {
                                                     return searchController.searchBar.text?.isEmpty ?? true
                                                 }

                                                 func isFiltering() -> Bool {
                                                     return searchController.isActive && !searchBarIsEmpty()
                                                 }

                                                 func filterContentForSearchText(_ searchText: String) {
                                                     filtredProducts = productsList.filter({(product: Product) -> Bool in
                                                         return product.name.lowercased().contains(searchText.lowercased())
                                                     })
                                                     tblView.reloadData()
                                                 }
                                                 return product.name.lowercased().contains(searchText.lowercased())
                                                     })
                                                     
                                                     tblView.reloadData()
                                                 }

                                                 // MARK: - Configure Table

                                                 func configureTable() {
                                                     tblView.dataSource = self
                                                     tblView.delegate = self
                                                     tblView.register(UINib(nibName: "ProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "productCell")
                                                     tblView.tableFooterView = UIView()
                                                     tblView.rowHeight = UITableView.automaticDimension
                                                     tblView.estimatedRowHeight = 140
                                                 }
