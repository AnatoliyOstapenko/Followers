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
    
    func getUserInfo(with username: String, completion: @escaping (Result<User, FollowerError>) -> Void) {
        let endPoint = baseURL + username
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
                // It's necessary if you changed type of property from String to Date in Model:
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.unableToComplete))
            }
        }
        task.resume()
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        //cache staff: if images already been downloaded, set images from cache
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self?.cache.setObject(image, forKey: cacheKey) // add images to cache
            completion(image)
        }
        task.resume()
    }
}
