//
//  NewsTableAdapter.swift
//  GB_VK
//
//  Created by Anatoliy on 28.12.2021.
//

import UIKit

final class NewsTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource, NewsPostCellDelegate {
    
    enum NewsCellType: Int, CaseIterable {
        case header
        case content
        case footer
    }
    
    weak var tableView: UITableView?
    var items: [NewsfeedItem] = []
    
    func connect(tableView: UITableView) {
        self.tableView = tableView
        setupTableView()
    }
    
    func setupTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func reload(items: [NewsfeedItem]) {
        self.items = items
        tableView?.reloadData()
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        if items.isEmpty {
            tableView.showEmptyMessage("Now news loaded.\nPull to refresh")
        } else {
            tableView.hideEmptyMessage()
        }
        
       return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        let cellType = NewsCellType(rawValue: indexPath.row) ?? .content
        var cellIdentifier = ""
        
        switch cellType {
        case .header:
            cellIdentifier = "NewsHeaderCell"
            
        case .content:
            cellIdentifier = contentCellIndetifier(item)
            
        case .footer:
            cellIdentifier = "NewsFooterCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsCell
        cell.configure(item: item)
        
        if let postCell = cell as? NewsPostCell {
            postCell.delegate = self
        }
        
        return cell
    }
    
    private func contentCellIndetifier(_ item: NewsfeedItem) -> String {
        switch item.type {
        case .post:
            return "NewsPostCell"
        case  .image, .wallPhoto:
            return "NewsImageCell"

        }
    }
    
    func didTappedShowMore(_ cell: NewsPostCell) {
        tableView?.beginUpdates()
        cell.isExpanded.toggle()
        tableView?.endUpdates()
    }

}
