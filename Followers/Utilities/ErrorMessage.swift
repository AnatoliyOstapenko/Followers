//
//  ErrorMessage.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 18.04.2022.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername = "This username created an invalid request, please try again"
    case unableToComplete = "Unable to complete your request, please check your internet connection"
    case invalidRequest = "Invalid response form server, please try again"
    case invalidData = "Data received from the server was invalid, please try again"
    
}
