//
//  String+Ext.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 28.04.2022.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplay() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return "GitHub since \(date.convertToString())"
    }
}
