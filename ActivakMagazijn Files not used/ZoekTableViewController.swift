//
//  ZoekTableViewController.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 25/09/2022.
//

import UIKit
import FirebaseFirestore

class ZoekTableViewController: UITableViewController {
    
    private var producten: [Product] = []
    
    let backgroundView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //background Photo
        backgroundView.image = UIImage(named: "logo")!
        backgroundView.contentMode = .scaleAspectFit
        backgroundView.alpha = 0.5
        tableView.backgroundView = backgroundView
        tableView.tableFooterView = UIView()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZoekCell",
                                                 for: indexPath) as! ProductenTableViewCell
            
        return cell
    }

}


class ProductenTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var thumbnailView: UIImageView!
        
    @IBOutlet weak private var nameLabel: UILabel!
        
    @IBOutlet weak var productDiscription: UILabel!
    
    @IBOutlet weak private var categoryLabel: UILabel!
}



