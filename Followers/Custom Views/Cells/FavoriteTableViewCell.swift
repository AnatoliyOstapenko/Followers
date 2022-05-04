//
//  FavoriteTableViewCell.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 01.05.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let reuseID = "FavoriteTableViewCellID"
    var avatarImageView = FollowerAvatarImageView(frame: .zero)
    let usernameLabel = FollowersTitleLabel(textAligment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        accessoryType = .disclosureIndicator
        contentView.setFavoriteAvatar(view: contentView, imageView: avatarImageView)
        contentView.setFavoriteUsername(view: contentView, label: usernameLabel, imageView: avatarImageView)
    }
    
    func updateFavoriteCellUI(favorites: Follower) {
        usernameLabel.text = favorites.login
        NetworkManager.shared.downloadImage(url: favorites.avatar) { [weak self] image in
            DispatchQueue.main.async {  self?.avatarImageView.image = image }
        }
    }
}
