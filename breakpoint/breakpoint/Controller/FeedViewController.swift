//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var feedTableView: UITableView!
    
    
    // MARK: Variables
    // Set messageArray
    var messageArray = [Message]()
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set self as table view delegate and datasource
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    // Load messageArray in viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getAllFeedMessages { (returnedMessageArray) in
            // set current message array to returned message array reversed so that new messages appear on top
            self.messageArray = returnedMessageArray.reversed()
            
            // reload table
            self.feedTableView.reloadData()
            
        }
        
    }
    
}


// Extension to conform as TableView Delegate and DataSource

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // If FeedTableViewCell can be created set it in the table view, otherwise return empty UITableViewCell
        guard let cell = feedTableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedTableViewCell else { return UITableViewCell() }
        
        // Get values for the Feed Cell
        
        // Preliminary image
        let image = UIImage(named: "defaultProfileImage")
        // message from the message array
        let message = messageArray [indexPath.row]
        
        // Call DataService function to get the username
        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
            // configure Feed Cell
            cell.configureCell(email: returnedUsername, content: message.content, profileImage: image!)
        }
        
        
        
        // Return the FeedCell
        return cell
    }
    
    
}
