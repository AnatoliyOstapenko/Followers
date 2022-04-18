//
//  NetworkManager.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 18.04.2022.
//

import Foundation

class NetworkManager {
    // Create singleton:
    static let shared = NetworkManager()
    init() {}
    
    let baseURL = "https://api.github.com/users/"
    
    func getFollowers(with username: String, page: Int, completion: @escaping([Follower]?, ErrorMessage?) -> Void) {
        let endPoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            completion(nil, .invalidUsername)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, .invalidRequest)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .unableToComplete)
                return
            }
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, .invalidData)
            }
        }
        task.resume()
    }
}
