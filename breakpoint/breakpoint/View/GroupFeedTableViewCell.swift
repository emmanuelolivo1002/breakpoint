//
//  GroupFeedTableViewCell.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 23/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class GroupFeedTableViewCell: UITableViewCell {


    // MARK: Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageContentLabel: UILabel!
    
    
    // MARK: Functions
    
    func configureCell(profileImage: UIImage, username: String, message: String) {
        profileImageView.image = profileImage
        usernameLabel.text = username
        messageContentLabel.text = message
    }

}
