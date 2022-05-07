//
//  FollowerAvatarImageView.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 19.04.2022.
//

import UIKit

class FollowerAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = Images.colorlessLogo
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    func setImage(avatar: String?) {
        NetworkManager.shared.downloadImage(url: avatar ?? ImageNames.placeholder) { [weak self] image in
            DispatchQueue.main.async { self?.image = image }
        }
    }
}
