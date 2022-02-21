//
//  GroupsTableViewCell.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var groupName: UILabel!
   
    @IBOutlet weak var groupPicture: UserPictureView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    func configure(group: Group) {
        selectionStyle = .none
//        NetworkRequest.shared.requestData(urlString: group.pictureURL) { [weak self ]result in
//
//            switch result {
//            case .success(let data):
//                let image = UIImage(data: data)
//                self?.groupPicture.imageView.image = image
//            case .failure(let error):
//                self?.groupPicture.imageView.image = UIImage(systemName: "person.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
//                print("No album logo" + error.localizedDescription)
//            }
//        }
        self.groupPicture.imageView.downloadImage(urlPatch: group.pictureURL)
        self.groupName.text = group.name
    }

}
