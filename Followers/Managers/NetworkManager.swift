//
//  NetworkManager.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 18.04.2022.
//

import UIKit

class NetworkManager {
    
    let cache = NSCache <NSString, UIImage>() // Create cache
    // Create singleton:
    static let shared = NetworkManager()
    init() {}
    
    let baseURL = "https://api.github.com/users/"
    func getFollowers(with username: String, page: Int, completion: @escaping (Result<[Follower], FollowerError>) -> Void) {
        let endPoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidRequest))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.unableToComplete))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.unableToComplete))
            }
        }
        task.resume()
    }
}
