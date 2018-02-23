//
//  GroupTableViewCell.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 22/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    
    
    func configureCell(title: String, description: String, numberOfMembers: Int) {
        groupTitleLabel.text = title
        descriptionLabel.text = description
        membersLabel.text = "\(numberOfMembers) members"
    }
    
}
