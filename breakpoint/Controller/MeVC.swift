//
//  MeVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 05/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit

class MeVC: UIViewController {

    // Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOutBtnPressed(_ sender: Any) {
        // sign out user
    }
    
}
