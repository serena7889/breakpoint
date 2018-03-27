//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 25/03/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    // Variables
    var group: Group?
    var groupMessages = [Message]()

    
    func initData(forGroup group: Group) {
        self.group = group
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        sendBtnView.bindToKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Keyboard Observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        // Set email label
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailsFor(group: group!) { (returnedEmailArray) in
            self.membersLbl.text = returnedEmailArray.joined(separator: ", ")
        }
        
        // Display messages
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                self.scrollToBottomMessage()
            })
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                bottomConstraint.constant = keyboardSize.height
                view.setNeedsLayout()
            }
        }
        scrollToBottomMessage()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0.0
        view.setNeedsLayout()
    }

    func scrollToBottomMessage() {
        if groupMessages.count > 0 {
            tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (complete) in
                if complete {
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                } else {
                    print("Message send failure")
                }
            })
        }
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImg: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
}

