//
//  MeViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions

    @IBAction func signOutButtonPressed(_ sender: Any) {
        //Sign out code
    }
    

}
