//
//  NewsTableViewController.swift
//  GB_VK
//
//  Created by Anatoliy on 12.11.2021.
//

import UIKit
import SwiftUI

class NewsTableViewController: UITableViewController//, UITableViewDataSourcePrefetching
{

//    enum NewsCellType: Int, CaseIterable {
//        case header
//        case content
//        case footer
//    }
    
    lazy var service = VKNewsfeedService()
    //var news: [NewsfeedItem] = []
    lazy var tableAdapter = NewsTableAdapter()
     
//    private var isLoading = false
//    private var nextFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        
        tableAdapter.connect(tableView: tableView)
        
        service.get(startTime: nil, startFrom: nil) { [weak self] items, _ in
            self?.tableAdapter.reload(items: items)
        }
        
//        tableView.prefetchDataSource = self
//        setupPullToRefresh()
    }
    
    private func setupPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
        //refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
//    @objc func refresh() {
//
//        var mostFreshDate: TimeInterval?
//
//        if let firstItem = news.first {
//            mostFreshDate = firstItem.date + 1
//        }
//
//        service.get(startTime: mostFreshDate) { [weak self] (items, nextFrom) in
//
//            guard let strongSelf = self else { return }
//
//            strongSelf.refreshControl?.endRefreshing()
//            strongSelf.news = items + strongSelf.news
//            strongSelf.tableView.reloadData()
//            strongSelf.nextFrom = nextFrom
//        }
//    }

    /*
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if news.isEmpty {
            tableView.showEmptyMessage("Now news loaded.\nPull to refresh")
        } else {
            tableView.hideEmptyMessage()
        }
        
       return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsCellType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = news[indexPath.section]
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
    */
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//
//        guard let maxRow = indexPaths.map ({ $0.section }).max(),
//        maxRow > news.count - 3,
//        isLoading == false
//        else { return }
//
//        isLoading = true
//
//        service.get(startFrom: nextFrom) { [weak self] items, nextFrom in
//            guard let strongSelf = self else { return }
//
//            let oldNewsCount = strongSelf.news.count
//            let newSections = (oldNewsCount..<(oldNewsCount + items.count)).map { $0 }
//
//            self?.news.append(contentsOf: items)
//            self?.tableView.insertSections(IndexSet(newSections), with: .automatic)
//            self?.isLoading = false
//        }
//    }
}
