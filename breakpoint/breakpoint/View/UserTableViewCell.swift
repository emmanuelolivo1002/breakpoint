//
//  UserTableViewCell.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 21/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Variables
    
    //Boolean to check status of checkmark
    var checkmarkShowing = false
    
    
    // MARK: Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Whenever cell is selected toggle the checkmark and the boolean flag
        if selected {
            if checkmarkShowing == false {
                // Show checkmark and toggle flag
                checkmarkImageView.isHidden = false
                checkmarkShowing = true
            } else {
                // Hide checkmark and toggle flag
                checkmarkImageView.isHidden = true
                checkmarkShowing = false
            }
        }
        
    }
    
    func configureCell (profileImage image: UIImage, email: String, isSelected: Bool) {
        profileImageView.image = image
        emailLabel.text = email
        
        // Check if user is selected
        if isSelected {
            checkmarkImageView.isHidden = false
        } else {
            checkmarkImageView.isHidden = true
        }
        
    }

}
