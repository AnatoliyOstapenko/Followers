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
    var publicRepos: Int
    var publicGists: Int
    var htmlURL: String
    var following: Int
    var followers: Int
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case login, name, location, bio, followers, following
        case avatar = "avatar_url"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case htmlURL = "html_url"
        case createdAt = "created_at"
        
    }
    
}
