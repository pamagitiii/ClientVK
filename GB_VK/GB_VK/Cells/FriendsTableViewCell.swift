//
//  FriendsTableViewCell.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendPhoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendPhoto.layer.cornerRadius = 10
    }
    
    func configure(user: User) {
//            NetworkRequest.shared.requestData(urlString: user.photoUrl) { [weak self] result in
//
//                switch result {
//
//                case .success(let data):
//                    let image = UIImage(data: data)
//                    self?.friendPhoto.image = image
//                case .failure(let error):
//                    self?.friendPhoto.image = UIImage(systemName: "person.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
//                    print("No album logo" + error.localizedDescription)
//                }
//            }
        
        self.friendName.text = user.lastName + " " + user.firstName
        self.friendPhoto.downloadImage(urlPatch: user.photoUrl)
    }

}
