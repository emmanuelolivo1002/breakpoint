//
//  DataService.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import Foundation
import Firebase

// Base URL for Firebase Database
let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS : DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference {
        return _REF_FEED
    }
    
    
    // MARK: Functions
    
    // Function to create new users in Database
    func createFirebaseUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    // Function to get username for a specific uid
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        
        // Get a snapshot from the Users table
        REF_USERS.observeSingleEvent(of: .value) { (usernameSnapshot) in
            
            // create a Snapshot otherwise return
            guard let usernameSnapshot = usernameSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            // loop through snapshot
            for user in usernameSnapshot {
                // user is equal to the uid return its email
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    // Function to upload post
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        
        if groupKey != nil {
            // if group key exists send to group
            
        } else {
            // send to feed
            REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderId" : uid])
            sendComplete(true)
        }
    }
    
    // Function to get all messages of the Feed
    func getAllFeedMessages (handler: @escaping (_ messages: [Message]) -> ()) {
       
        // Set preliminary messageArray
        var messageArray = [Message]()
        
        // Get snapshot of messages in feed
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            // Loop through snapshot and append message values to messageArray
            for message in feedMessageSnapshot {
                // Get content and senderId
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                
                // Set message as a Message object with content and senderId
                let message = Message(content: content, senderId: senderId)
                
                // Append message to messageArray
                messageArray.append(message)
            }
            // Return the messageArray to the handler after for loop is done
            handler(messageArray)
        }
    }
    
    // Function for searching emails
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        // Initialize array of emails that will be shown
        var emailArray = [String]()
        
        // Get snapshot of all users
        REF_USERS.observe(.value) { (userSnapshot) in
            
            // Create userSnapshot otherwise return
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            // Loop through users in snapshot
            for user in userSnapshot {
                // Get email
                let email = user.childSnapshot(forPath: "email").value as! String
                
                // If email contains whats in the query and is not the current user's email
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    // Append to array of emails shown
                    emailArray.append(email)
                }
                handler(emailArray)
            }
        }
    }
    
    // Function to get ids for usernames
    func getIds(forUsernames usernames: [String], handler: @escaping(_ uidArray: [String]) -> ()) {
        // Create a snapshot for all usernames
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            // Initialize an array for ids
            var idArray = [String]()
            
            // Loop through user snapshot
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                // Get email of user
                let email = user.childSnapshot(forPath: "email").value as! String
                
                // if email is in array of usernames requested
                if usernames.contains(email) {
                    // append Id to idArray to return
                    idArray.append(user.key)
                }
            }
            
            // Return array in handler
            handler(idArray)
        }
    }
    
    // Function to create group in database
    func createGroup(withTitle title: String, andDescription description: String, forUserIds ids: [String], handler: @escaping(_ createdGroup: Bool) -> ()) {
        // Add group to Database
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    
    
    
}
