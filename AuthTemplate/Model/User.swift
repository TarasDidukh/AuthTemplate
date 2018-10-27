//
//  User.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/26/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import RealmSwift

struct UserResult : Codable {
    let data: User?
}

class User: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var avatar: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
