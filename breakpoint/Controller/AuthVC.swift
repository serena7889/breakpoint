//
//  AuthVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 01/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookSignInBtnPressed(_ sender: Any) {
    }

    @IBAction func googleSignInBtnPressed(_ sender: Any) {
    }
    
    @IBAction func emailSignInBtnPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
}
