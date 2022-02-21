//
//  FriendsTableViewController.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
    var timer: Timer?
    lazy var service = VKService()
    var filteredData: [User]!
    lazy var dataBase = DBManager()
    var sections: [Character: [User]] = [:]
    var sectionTitles = [Character]()
    
    var data = [User]() {
        didSet {
            filteredData = data
            setupArrays()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        loadFromCache()

        service.getFriends { [weak self] in
            self?.loadFromCache()
        }
    }
    
    private func setupArrays() {
        sections = [:]
        sectionTitles = []

        for friend in filteredData {

            let firstLetter = friend.lastName.first!

            if sections[firstLetter] != nil {
                sections[firstLetter]?.append(friend)
            } else {
                sections[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sections.keys)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  sections[sectionTitles[section]]?.count ?? 0
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles.map{ String($0) }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sectionTitles[section])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
        guard let friend = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { return UITableViewCell() }
        cell.configure(user: friend)
        return cell
    }
    
    //MARK: - Переход
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotosSegue" {
            if let vc = segue.destination as? FriendPhotoCollectionViewController {
                 let id = sender as? Int ?? 1
                 let stringUserId = String(describing: id)
                vc.userId = stringUserId
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tappedFriendId = sections[sectionTitles[indexPath.section]]?[indexPath.row].id else { return }
        self.performSegue(withIdentifier: "showPhotosSegue", sender: tappedFriendId)
    }
    
    //MARK: - чтение списка друзей из Realm
    private func loadFromCache() {
        data = dataBase.fetchUsers()
        tableView.reloadData()
    }
    
}

//MARK: - Логика поиска по таблице
extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = data
            setupArrays()
            tableView.reloadData()
        } else {
            filteredData = []
            for user in data {
                if  user.firstName.contains(searchText) || user.lastName.contains(searchText) {
                    filteredData.append(user)
                }
            }
            setupArrays()
            tableView.reloadData()
        }
    }
}
