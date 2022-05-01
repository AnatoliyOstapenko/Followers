//
//  ErrorMessage.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 18.04.2022.
//

import Foundation

enum FollowerError: String, Error {
    case invalidUsername = "This username created an invalid request, please try again 🦄"
    case unableToComplete = "Unable to complete your request, please check your internet connection 🦄"
    case invalidRequest = "Invalid response form server, please try again 🦄"
    case invalidData = "Data received from the server was invalid, please try again 🦄"
    case noFollowers = "There are no followers at all, please chek another one 🦄"
    case invalidUser = "URL attached to this user is invalid 🦄"
    case unableToFavorite = "Unable to add to favorites, please try again 🦄"
    case userAlreadyExist = "Unable to add to favorites, user is already exist 🦄"
    case userAdded = "User successfully added 📥" // FIXME: Don't forget to delete
    case userRemoved = "User successfully removed 📤" // FIXME: Don't forget to delete
}
