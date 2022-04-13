//
//  FollowersTextField.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 13.04.2022.
//

import UIKit

class FollowersTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 2
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = .preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        placeholder = "Enter a username"
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
