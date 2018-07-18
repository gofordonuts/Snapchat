//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by William Beutel on 7/15/18.
//  Copyright © 2018 Maria Beutel. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    var imageURL = ""
    var snapDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            
            let user = User()
            let value = snapshot.value as? NSDictionary
            user.email = (value?["email"] as? String)!
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from" : user.email, "description" : "test description", "imageURL" : "wwww.test.com"]
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }

}
