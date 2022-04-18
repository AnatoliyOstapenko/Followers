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
    
    func getFollowers(with username: String, page: Int, completion: @escaping([Follower]?, String?) -> Void) {
        let endPoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            completion(nil, "This username created an invalid request, please try again")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, "Unable to complete your request, please check your internet connection")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response form server, please try again")
                return
            }
            guard let data = data else {
                completion(nil, "Data received from the server was invalid, please try again")
                return
            }
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "")
            }
        }
        task.resume()
    }
}
