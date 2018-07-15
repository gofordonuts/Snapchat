//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by William Beutel on 7/15/18.
//  Copyright © 2018 Maria Beutel. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            print("Auth successfully signed out")
        } catch let error as NSError {
            print("We failed to sign out: \(error)")
        }
       
        
        dismiss(animated: true, completion: nil)
    }


}
