//
//  NewsImageCell.swift
//  GB_VK
//
//  Created by Anatoliy on 18.12.2021.
//

import UIKit
import Kingfisher

class NewsImageCell: UITableViewCell, NewsConfigurable {


    @IBOutlet weak var newsImageView: UIImageView!
    
    func configure(item: NewsfeedItem) {
        if  let imageUrl = item.photo?.imageUrl,
            let url = URL(string: imageUrl) {
            newsImageView.kf.setImage(with: url)
        }
        
//        guard let imageName = item.photo else { return }
//        newsImageView.image = UIImage(named: imageName)
    }
    
}
