//
//  GroupCell.swift
//  breakpoint
//
//  Created by Serena Lambert on 21/03/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var tableView: UILabel!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitleLbl.text = title
        self.groupDescriptionLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members"
    }
    
}
