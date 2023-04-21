//
//  tblViewDetail.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 25/12/2022.
//

import UIKit

class tblViewDetail: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedItem: productModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension tblViewDetail: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // replace with the number of rows you need to display
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCell
        cell.item = selectedItem
        return cell
    }
    
}

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: productModel? {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        guard let item = item else { return }
        nameLabel.text = item.name
        if let url = URL(string: item.imageLink) {
            itemImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}

