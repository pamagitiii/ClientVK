//
//  Group.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import Foundation

struct Group: Decodable {
    let name: String
    let pictureURL: String
    
    enum GroupKeys: String, CodingKey {
        case name
        case pictureURL = "photo_100"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GroupKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.pictureURL = try container.decode(String.self, forKey: .pictureURL)

    }
    
}
