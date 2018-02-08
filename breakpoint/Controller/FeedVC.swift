//
//  FeedVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 01/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }

}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderID) { (returnedUsername) in
            cell.configureCell(profileImg: image!, email: returnedUsername, content: message.content)
        }
        return cell
    }
}

