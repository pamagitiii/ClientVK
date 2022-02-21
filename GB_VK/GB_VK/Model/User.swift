//
//  User.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import Foundation
import RealmSwift

class User: Object, Decodable {
    @objc dynamic var firstName: String
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var photoUrl: String
    
    static override func primaryKey() -> String? {
        "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photoUrl = "photo_100"
    }
    
//        init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: UserKeys.self)
//
//        self.firstName = try container.decode(String.self, forKey: .firstName)
//        self.lastName = try container.decode(String.self, forKey: .lastName)
//        self.photoUrl = try container.decode(String.self, forKey: .photoUrl)
//        self.id = try container.decode(Int.self, forKey: .id)
//    }
}
