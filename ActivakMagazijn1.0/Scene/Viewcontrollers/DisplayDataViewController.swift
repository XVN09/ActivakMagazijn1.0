//
//  TableViewController.swift
//  ActivakMagazijn1.0
//
//  Created by Xander Van nuffel on 14/04/2023.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class DisplayDataViewController : UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var noDataLabel : UILabel!
    var dataArray : [MyData] = []
    let reuseIdentifier = "DataCell"
    
    var ref = Database.database().reference()
    var databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        noDataLabel.isHidden = false
        fetchDataFromFirebase()


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DataCell else {
            return UITableViewCell()
        }
        
        
        cell.setValues(data: dataArray[indexPath.row])
        
        return cell
        
    }
    
    func fetchDataFromFirebase()
    {
        self.dataArray=[]

        ref.child("1QmF9fFlYh5S4TkM_ifD-42i2ABKMC-8pVacw5L1tFGY").child("Producten").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key

                self.ref.child("1QmF9fFlYh5S4TkM_ifD-42i2ABKMC-8pVacw5L1tFGY").child("Producten").child(key).observeSingleEvent(of: .value) { snapshot in
                    let value = (snapshot ).value as? NSDictionary
                                if value != nil {
                                    self.noDataLabel.isHidden = true
                                    let data = MyData.init()
                                let url = value?["Image"] as? String ?? ""
                                let title = value?["Title"] as? String ?? ""
                                let place = value?["Place"] as? String ?? ""
                                let price = value?["Price"] as? String ?? ""
                                    
                                    data.setData(url: url, title: title, place: place, price: price)
                                    self.dataArray.append(data)
                                } else
                                {
                                    self.noDataLabel.isHidden = false
                                }
                                self.tableView.reloadData()
                }
            }
        })
    }
    
    @IBAction func LoginButtonTapped(){
        if Auth.auth().currentUser?.uid != nil
        {
            self.performSegue(withIdentifier: "LoggedInSegue", sender: self)
        } else
        {
            self.performSegue(withIdentifier: "AccountStartScreenSegue", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedData = dataArray[indexPath.row]
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                return
            }
            
            detailViewController.data = selectedData
            navigationController?.pushViewController(detailViewController, animated: true)
        }
}
