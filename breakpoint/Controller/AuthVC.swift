//
//  AuthVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 01/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
