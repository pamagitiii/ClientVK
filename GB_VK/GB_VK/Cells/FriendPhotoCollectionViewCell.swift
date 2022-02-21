//
//  FriendPhotoCollectionViewCell.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit

class FriendPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhotoImageView: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    
    func configure(photo: Photo) {
       // let urlString = photo.photoSizes.first(where: {$0.type == "q"})?.url ?? "fff"
        
//        NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
//            switch result {
//            case .success(let data):
//                let image = UIImage(data: data)
//                self?.activityIndicator.stopAnimating()
//                self?.friendPhotoImageView.image = image
//            case .failure(let error):
//                self?.activityIndicator.stopAnimating()
//                self?.friendPhotoImageView.image = UIImage(systemName: "person.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
//                print("No album logo" + error.localizedDescription)
//            }
//        }
        print("____________________________________________________")
        print(photo.ownerId)
        self.friendPhotoImageView.downloadImage(urlPatch: photo.photoUrl)
        self.likeControl.likesCountLabel.text = String(photo.likesCount)
    }
}
