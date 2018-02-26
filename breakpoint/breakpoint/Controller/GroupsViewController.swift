//
//  GroupsViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {

    
    // MARK: Outlets
    @IBOutlet weak var groupTableView: UITableView!
    
    // MARK: Variables
    var groupsArray = [Group]()

    
    
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set self as tablevieew delgate and datasource
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Observe every time there is a change in database
        DataService.instance.REF_GROUPS.observeSingleEvent(of: .value) { (snapshot) in
            DataService.instance.getAllGroups { (returnedGroupsArray) in
                // Set local groups array to be equal to the returned array and reload data
                self.groupsArray = returnedGroupsArray
                self.groupTableView.reloadData()
            }
        }
        
        
       
    }

 

}

// Conform to tableview protocols
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupTableViewCell else {return UITableViewCell()}
        
        
        
        cell.configureCell(title: groupsArray[indexPath.row].groupTitle, description: groupsArray[indexPath.row].groupDescription, numberOfMembers: groupsArray[indexPath.row].memberCount)
        
        return cell
    }
    
    
    // When a row is selected show the feed for that group
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set a storyboard for groupFeedViewController
        guard let groupFeedViewController = storyboard?.instantiateViewController(withIdentifier: "GroupFeedViewController") as? GroupFeedViewController else { return }
        
        // Initialize group in groupFeedViewController by passing the group selected
        groupFeedViewController.initData(forGroup: groupsArray[indexPath.row])
        
        // present groupFeedViewController
        present(groupFeedViewController, animated: true, completion: nil)
        
    }
    
    
}
