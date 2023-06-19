import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class DisplayDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {

    // MARK: Variables and outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rotatingThing: UIActivityIndicatorView!

    var dataArray: [MyData] = []
    var filteredDataArray: [MyData] = [] // For storing filtered data
    var categoryFilter: [MyData] = []
    let reuseIdentifier = "DataCell"

    var ref = Database.database().reference()
    var databaseRef = Database.database().reference()

    let searchController = UISearchController(searchResultsController: nil)
    var categories: [String] = [] // Array to store unique categories

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        ref = Database.database().reference()

        rotatingThing.isHidden = false
        rotatingThing.startAnimating()

        // Configure search controller
       searchController.searchResultsUpdater = self
       searchController.obscuresBackgroundDuringPresentation = false
       searchController.searchBar.placeholder = "Search"
       navigationItem.searchController = searchController
       definesPresentationContext = true
       
       let categoryButton = UIButton(type: .custom)
               categoryButton.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
               categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
               searchController.searchBar.searchTextField.leftView = categoryButton
               searchController.searchBar.searchTextField.leftView?.tintColor = .black
               searchController.searchBar.searchTextField.leftViewMode = .whileEditing
        // Fetch data from Firebase
        fetchDataFromFirebase()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Reload table view data when the view appears
        tableView.reloadData()
    }

    // MARK: TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredDataArray.count
        }
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DataCell else {
            return UITableViewCell()
        }

        let data: MyData
        if isFiltering() {
            data = filteredDataArray[indexPath.row]
        } else {
            data = dataArray[indexPath.row]
        }

        cell.setValues(data: data)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData: MyData
        if isFiltering() {
            selectedData = filteredDataArray[indexPath.row]
        } else {
            selectedData = dataArray[indexPath.row]
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }

        detailViewController.data = selectedData
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    // MARK: Search Bar Methods

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredDataArray = dataArray.filter { data in
            let titleMatch = data.titleText.lowercased().contains(searchText.lowercased())
            let placeMatch = data.placeText.lowercased().contains(searchText.lowercased())
            let priceMatch = data.priceText.lowercased().contains(searchText.lowercased())
            let categoryMatch = data.catText.lowercased().contains(searchText.lowercased())

            return titleMatch || placeMatch || priceMatch || categoryMatch
        }

        tableView.reloadData()
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()

    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    // MARK: Firebase Data Methods

    func fetchDataFromFirebase() {
        self.dataArray = []

        ref.child("1QmF9fFlYh5S4TkM_ifD-42i2ABKMC-8pVacw5L1tFGY").child("Producten").observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key

                self.ref.child("1QmF9fFlYh5S4TkM_ifD-42i2ABKMC-8pVacw5L1tFGY").child("Producten").child(key).observeSingleEvent(of: .value) { snapshot  in
                    let value = snapshot.value as? NSDictionary
                    if value != nil {
                        self.rotatingThing.isHidden = true
                        self.rotatingThing.stopAnimating()
                        let data = MyData()
                        let url = value?["Image"] as? String ?? ""
                        let title = value?["Title"] as? String ?? ""
                        let place = value?["Place"] as? String ?? ""
                        let price = value?["Price"] as? String ?? ""
                        let description = value?["Description"] as? String ?? ""
                        let category = value?["Category"] as? String ?? ""

                        data.setData(url: url, title: title, place: place, price: price, descripiton: description, category: category)
                        self.dataArray.append(data)

                        // Update categories array with unique categories
                        if !self.categories.contains(category) {
                            self.categories.append(category)
                        }
                    } else {
                        self.rotatingThing.isHidden = false
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: Category Button

    @objc func categoryButtonTapped() {
        let alertController = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)

        for category in categories {
            let action = UIAlertAction(title: category, style: .default) { [weak self] _ in
                self?.filterContentForCategory(category)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }

        present(alertController, animated: true, completion: nil)
    }

    func filterContentForCategory(_ category: String) {
        categoryFilter = dataArray.filter { $0.catText.lowercased() == category.lowercased() }
        tableView.reloadData()
    }
    
    // MARK: Segue
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    
        if Constants.isUserLoggedIn == true {
            self.performSegue(withIdentifier: "LoggedInSegue", sender:  nil)
        } else {
            self.performSegue(withIdentifier: "AccountStartScreenSegue", sender: nil)
        }
        
    }
    
}
