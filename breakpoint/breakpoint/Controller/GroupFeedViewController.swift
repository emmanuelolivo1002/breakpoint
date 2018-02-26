//
//  GroupFeedViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 23/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendMessageTextField: InsetTextField!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: Variables
    // Setup an initial group optionally
    var group: Group?
    
    // Set local array for messages
    var groupMessages = [Message]()
    
    
    // MARK: Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        // Check if message is not empty
        
        if sendMessageTextField.text != "" {
            
            // Disable textfield and send button
            sendMessageTextField.isEnabled = false
            sendButton.isEnabled = false
            
            // Upload message
            DataService.instance.uploadPost(withMessage: sendMessageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.groupId, sendComplete: { (complete) in
                
                if complete {
                    // Clear textfield
                    self.sendMessageTextField.text = ""
                    // Enabled texfield and button
                    self.sendMessageTextField.isEnabled = true
                    self.sendButton.isEnabled = true
                    self.groupFeedTableView.reloadData()
                    
                }
                
                
            })
            
        }
        
        
    }
    
    
    // MARK: Funtions
    
    // Function to initialize current group with group passed from GroupsViewController
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    // Setup the view with data from group
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.groupFeedTableView.estimatedRowHeight = 0
        self.groupFeedTableView.estimatedSectionHeaderHeight = 0
        self.groupFeedTableView.estimatedSectionFooterHeight = 0
        
        groupTitleLabel.text = group?.groupTitle
        
        // Get usernames for the group to display at the top
        DataService.instance.getUsernames(forGroup: group!) { (returnedUsernames) in
            self.membersLabel.text = returnedUsernames.joined(separator: ", ")
        }
        
        // Observe when there is a change in database
        DataService.instance.REF_GROUPS.observeSingleEvent(of: .value) { (snapshot) in
            // Get messages from the database for current group
            DataService.instance.getAllMessages(forGroup: self.group!) { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.groupFeedTableView.reloadData()
                
                // Scroll to bottom of table view
                if self.groupMessages.count > 0 {
                    self.groupFeedTableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1 , section: 0), at: .none, animated: true)
                }
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Set self as delegate and datasource of tableview
        groupFeedTableView.delegate = self
        groupFeedTableView.dataSource = self
        
        // Bind message view to keyboard
        sendMessageView.bindToKeyboard()
    }

   

    
}

// MARK: Tableview extensions
extension GroupFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  groupFeedTableView.dequeueReusableCell(withIdentifier: "GroupFeedCell") as? GroupFeedTableViewCell else {return UITableViewCell()}
        
        let currentMessage = groupMessages[indexPath.row]
        
        let profileImage = UIImage(named: "defaultProfileImage")
        
        // Get email for user that sent the message
        DataService.instance.getUsername(forUID: currentMessage.senderId) { (email) in
            cell.configureCell(profileImage: profileImage!, username: email, message: currentMessage.content)
        }
        return cell
    }
    
    
}


