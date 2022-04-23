//
//  FollowerEmptyStateView.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 21.04.2022.
//

import UIKit

class FollowerEmptyStateView: UIView {
    
    let messageLabel = FollowersTitleLabel(textAligment: .center, fontSize: 26)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: FollowerError) {
        super.init(frame: .zero)
        messageLabel.text = message.rawValue
        configure()
    }
    
    private func configure() {
        setLogoImageView(view: self, imageView: logoImageView)
        setMessageLabel(view: self, label: messageLabel)
    }
    
    
}
