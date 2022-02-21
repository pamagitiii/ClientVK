//
//  NewsCellProtocol.swift
//  GB_VK
//
//  Created by Anatoliy on 18.12.2021.
//

import UIKit

typealias NewsCell = UITableViewCell & NewsConfigurable

protocol NewsConfigurable {
    func configure(item: NewsfeedItem)
}
