//
//  FollowerCollectionViewCell.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 19.04.2022.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCollectionViewCell"
    let avatarImage = FollowerAvatarImageView(frame: .zero)
    let usernameLabel = FollowersTitleLabel(textAligment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.configureFollowerCell(view: contentView, image: avatarImage, label: usernameLabel)
    }
    
    func setFollower(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImage.downloadImage(urlString: follower.avatar)
    }
    
}
