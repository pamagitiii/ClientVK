//
//  AvailableGroupsTableViewController.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit

class AvailableGroupsTableViewController: UITableViewController {
    
    var timer: Timer?
    lazy var service = VKService()
    var resultGroups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Available Groups"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "availableGroupCell", for: indexPath) as? AvailableGroupsTableViewCell {
            cell.configure(group: resultGroups[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }

    }

}

extension AvailableGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            let newSearchText = text?.replacingOccurrences(of: " ", with: "%20")
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] _ in
                self?.service.searchGroups(text: newSearchText!, completion: { [weak self] groups in
                    self?.resultGroups = groups
                    self?.tableView.reloadData()
                })
                
            })
        }
        
        
    }

}
