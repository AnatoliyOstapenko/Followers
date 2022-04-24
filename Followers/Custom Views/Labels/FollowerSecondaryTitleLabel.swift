//
//  FollowerSecondaryTitleLabel.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 24.04.2022.
//

import UIKit

class FollowerSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = .systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
