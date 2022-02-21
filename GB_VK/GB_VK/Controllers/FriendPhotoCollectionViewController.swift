//
//  FriendPhotoCollectionViewController.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit


class FriendPhotoCollectionViewController: UICollectionViewController {
    
    var userId = ""
    
    lazy var service = VKService()
    lazy var dataBase = DBManager()
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        service.getPhotos(userId: userId) { [weak self] in
            self?.loadFromCache()
        }
       
        
//        service.getPhotos(userId: userId) { [weak self] in
//            self?.loadFromCache()
//        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as? FriendPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(photo: photos[indexPath.row])
        return cell
    }
    
    private func loadFromCache() {
        photos = dataBase.fetchPhotos(ownerId: userId)
        print("коллекция фотографий пользователя")
        print(photos.count)
        collectionView.reloadData()
    }
}
