//
//  String+Ext.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 28.04.2022.
//

import Foundation

extension String {
    
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = .current
        return dateFormatter
    }
}
