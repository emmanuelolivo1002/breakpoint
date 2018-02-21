//
//  MeViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit
import Firebase

class MeViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailLabel.text = Auth.auth().currentUser?.email
    }
    
    // MARK: Actions
    @IBAction func signOutButtonPressed(_ sender: Any) {
        // Create logout popup
        let logoutPopup = UIAlertController(title: "Log out", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        // Create action to happend when popup button is tapped
        let logoutAction = UIAlertAction(title: "Log out", style: .destructive) { (buttonTapped) in
            
            // Perform sign out in a do try block
            do {
                // Try to perform sign out
                try Auth.auth().signOut()
                // if successful present auth View Controller
                let authViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController
                self.present(authViewController!, animated: true, completion: nil)
                
            } catch {
                // If there is an error
                print(error)
            }
        }
        
        //Add action created to popup
        logoutPopup.addAction(logoutAction)
        // Present logout popup
        present(logoutPopup, animated: true, completion: nil)
        
    }
    

}
