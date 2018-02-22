//
//  CreateGroupsViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 21/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsViewController: UIViewController {
    
    
    // MARK: Outlets
    @IBOutlet weak var tittleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var usersTableView: UITableView!
    

    // MARK: Variables
    
    // Initialize email array for search query
    var emailArray = [String]()
    // Array for users selected
    var selectedUserArray = [String]()
    
    
    // MARK: Actions
 
    @IBAction func doneButtonPressed(_ sender: Any) {
        // if title and description are not empty
        if tittleTextField.text != "" && descriptionTextField.text != "" {
            
            // Get ids for users selected in the group
            DataService.instance.getIds(forUsernames: selectedUserArray, handler: { (idsArray) in
                // Create a temporary array for the ids
                var userIds = idsArray
                
                // Append currend user to array
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                // Save array in Database
                DataService.instance.createGroup(withTitle: self.tittleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    // Dismiss view once a new group is created
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group could not be created")
                    }
                    
                })
                
                
            })
            
        }
        
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide done button by default
        doneButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set self as tableview delegate and datasource
        usersTableView.delegate = self
        usersTableView.dataSource = self
        
        // Set self as textfield delegate
        emailSearchTextField.delegate = self
        // Add target whenever textfield changes
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }

    // Function to execute whenever textfield changes
    @objc func textFieldDidChange () {
        
        // if search query is empty show the array as empty
        if emailSearchTextField.text == "" {
            emailArray = []
            usersTableView.reloadData()
        } else {
            // if there is a search in textfield start getting emails from database
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnedEmailArray) in
                // Load emailArray with result and reload the data
                self.emailArray = returnedEmailArray
                self.usersTableView.reloadData()
            })
        }
        
    }



}

// Conform to Tableview delegate and data source
extension CreateGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserTableViewCell else { return UITableViewCell() }
        
        // Set imageview
        let image = UIImage(named: "defaultProfileImage")
        
        // Configure User Cell depending on whether or not user is in the array
        if selectedUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: image!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: image!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        
        return cell
    }
    
    // If selected add to the array of users
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get cell selected
        guard let cell =  usersTableView.cellForRow(at: indexPath) as? UserTableViewCell else { return }
        
        // If user array does NOT contain the user selected
        if !selectedUserArray.contains(cell.emailLabel.text!) {
            
            // append to array
            selectedUserArray.append(cell.emailLabel.text!)
            
            // make users appear on the label
            groupMemberLabel.text = selectedUserArray.joined(separator: ", ")
            
            // Show done button
            doneButton.isHidden = false
            
        } else { // If user IS in the array
            
            // Remove it from the array by using a filter
            selectedUserArray = selectedUserArray.filter({ $0 != cell.emailLabel.text!})
            
            // If array already has members use separator
            if selectedUserArray.count >= 1 {
                groupMemberLabel.text = selectedUserArray.joined(separator: ", ")
            } else { // If array is empty display label and hide done button
                groupMemberLabel.text = "add people to your group"
                doneButton.isHidden = true
                
            }
            
        }
        
        
    }
    
    
}

// Extension for Textfield Delegate
extension CreateGroupsViewController: UITextFieldDelegate {
    
}
