//
//  User.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 18.04.2022.
//

import Foundation

struct User: Codable {
    var login: String
    var avatar: String
    var name: String?
    var location: String?
    var bio: String?
}
