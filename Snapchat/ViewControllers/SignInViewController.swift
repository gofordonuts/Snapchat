//
//  SignInViewController.swift
//  Snapchat
//
//  Created by William Beutel on 7/7/18.
//  Copyright © 2018 Maria Beutel. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func turnUpTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("Error signing into existing account: \(String(describing:error))")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    if error != nil {
                        print("Error creating new account: \(String(describing: error))")
                    } else {
                        print("Successfully created new account")
                    Database.database().reference().child("users").child(user!.user.uid).child("email").setValue(user!.user.email)
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            } else {
                print("Successfully logged into existing account")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
                
            }
        }
    }

}
