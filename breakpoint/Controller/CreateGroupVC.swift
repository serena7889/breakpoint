//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 13/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    // OUTLETS
    @IBOutlet weak var titleTxtField: InsetTextField!
    @IBOutlet weak var descriptionTxtField: InsetTextField!
    @IBOutlet weak var emailSearchTxtField: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxtField.delegate = self
        emailSearchTxtField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @objc func textFieldDidChange() {
        if emailSearchTxtField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTxtField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleTxtField.text != "" && descriptionTxtField.text != "" {
            DataService.instance.getIds(forUsernames: chosenUserArray, handler: { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withTitle: self.titleTxtField.text!, andDescription: self.descriptionTxtField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group could not be created. Please try again.")
                    }
                })
            })
        }
    }
    
}


extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {
            return UITableViewCell()
        }
        let profileImg = UIImage(named: "defaultProfileImage")
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImg!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImg!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text! })
            if chosenUserArray.count >= 1 {
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "ADD PEOPLE TO YOUR GROUP"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupVC: UITextFieldDelegate {
}
