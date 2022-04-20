//
//  Follower.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 17.04.2022.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatar = "avatar_url"
    }
}
