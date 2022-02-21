//
//  DBManager.swift
//  GB_VK
//
//  Created by Anatoliy on 14.12.2021.
//

import Foundation
import RealmSwift

class DBManager {
    private let realm = try! Realm()
    
    func fetchUsers() -> [User] {
        return Array(realm.objects(User.self))
    }
    
    func fetchPhotos(ownerId: String) -> [Photo] {
        return Array(realm.objects(Photo.self).filter("ownerId == \(ownerId)"))
    }
}
