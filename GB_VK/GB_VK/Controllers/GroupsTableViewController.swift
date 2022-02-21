//
//  GroupsTableViewController.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    lazy private var service = VKService()
    var groups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        
        service.getGroups { [weak self] groups in
            self?.groups = groups

            self?.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
        
//              let defaultGroup = groups.filter { $0.pictureURL == "p"}
//        groups.first?.pictureURL = "ff"
//        groups.forEach { group in
//            group.pictureURL = defaultGroup.first?.pictureURL
//        }
//
//
        cell.configure(group: groups[indexPath.row])
        
            return cell
  
    }

}
