//
//  AuthViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    // MARK: Outlets
    
    
    // MARK: Actions
    
    @IBAction func signInWithEmailButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func signInWithFacebookButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signInWithGooglePlusButtonPressed(_ sender: Any) {
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Dissmiss view if user is logged in
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    

}
