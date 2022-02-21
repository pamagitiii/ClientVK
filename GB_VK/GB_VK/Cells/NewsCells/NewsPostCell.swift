//
//  NewsPostCell.swift
//  GB_VK
//
//  Created by Anatoliy on 18.12.2021.
//

import UIKit

protocol NewsPostCellDelegate: AnyObject {
    func didTappedShowMore(_ cell: NewsPostCell)
}

class NewsPostCell: UITableViewCell, NewsConfigurable {

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    
    weak var delegate: NewsPostCellDelegate?
    
    var isExpanded = false {
        didSet {
            updatePostLabel()
            updateShowMoreButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updatePostLabel()
        updateShowMoreButton()
    }
    
    @IBAction func showMoreButtonTapped(_ sender: UIButton) {
        delegate?.didTappedShowMore(self)
        //isExpanded.toggle()
    }
    
    func configure(item: NewsfeedItem) {
        postLabel.text = item.text
    }
    
    func updatePostLabel() {
        postLabel.numberOfLines = isExpanded ? 0 : 3
    }
    
    func updateShowMoreButton() {
        let title = isExpanded ? "Show less..." : "Show more..."
        showMoreButton.setTitle(title, for: .normal)
    }
    
}
