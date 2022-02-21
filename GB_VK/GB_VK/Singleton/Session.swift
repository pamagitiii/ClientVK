//
//  Session.swift
//  GB_VK
//
//  Created by Anatoliy on 18.11.2021.
//

import Foundation

class Session {
    static let instance = Session()
    
    private init() {}
    
    var token = ""
    var userId = ""
}
