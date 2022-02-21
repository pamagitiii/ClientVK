//
//  NewsHeaderCell.swift
//  GB_VK
//
//  Created by Anatoliy on 18.12.2021.
//

import UIKit
import Kingfisher

class NewsHeaderCell: UITableViewCell, NewsConfigurable {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorImageView: AsyncImageView!
    
    func configure(item: NewsfeedItem) {
        if  let authorImageUrl = item.authorImageUrl,
            let url = URL(string: authorImageUrl) {
            authorImageView.kf.setImage(with: url)
        }
        authorLabel.text = item.author
        dateLabel.text = "25.12.2021"
    }
}
