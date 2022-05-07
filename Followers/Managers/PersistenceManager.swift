//
//  PersistenceManager.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 30.04.2022.
//

import Foundation

enum PersistanceActionType { case add, remove }

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping (FollowerError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.userAlreadyExist)
                        return }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completion(save(favorites: favorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(competion: @escaping (Result<[Follower], FollowerError>) -> Void) {
        guard let data = defaults.object(forKey: Keys.favorites) as? Data else {
            competion(.success([])) // return empty array in case no data
            competion(.failure(.noFavorites))
            return
        }
        do {
            let favorites = try JSONDecoder().decode([Follower].self, from: data)
            competion(.success(favorites))
        } catch {
            competion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> FollowerError? {
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch { return .unableToFavorite }
    }
}

