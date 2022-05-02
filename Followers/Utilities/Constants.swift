//
//  Constants.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 24.04.2022.
//

import UIKit

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}

enum Keys {
    static let favorites = "favorites"
}

// MARK: - Adaptation for any screens

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isiPhoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736
    static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736 && nativeScale < scale
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLength == 812
    static let isiPhoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896
    static let isiPad = idiom == .pad && ScreenSize.maxLength == 1024
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
