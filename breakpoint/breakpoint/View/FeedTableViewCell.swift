//
//  FeedTableViewCell.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageContentLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: Functions
    func configureCell(email: String, content: String, profileImage: UIImage ) {
        self.emailLabel.text = email
        self.messageContentLabel.text = content
        self.profileImageView.image = profileImage
        
    }
    
    
}
