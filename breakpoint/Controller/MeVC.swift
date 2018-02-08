//
//  MeVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 05/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit
import  Firebase

class MeVC: UIViewController {

    // Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    @IBAction func signOutBtnPressed(_ sender: Any) {
        let logoutPopUp = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print("Sign out error: \(error.localizedDescription)")
            }
        }
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp, animated: true, completion: nil)
    }
    
}
