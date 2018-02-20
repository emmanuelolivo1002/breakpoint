//
//  AuthService.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    // Create singleton class
    static let instance =  AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider" : user.providerID, "email" : user.email]
            DataService.instance.createFirebaseUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
            
        }
        
        
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ())  {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
            
        }
    }
    
    
}
