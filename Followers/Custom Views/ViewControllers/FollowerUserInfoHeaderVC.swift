//
//  FollowerUserInfoHeaderVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 24.04.2022.
//

import UIKit

class FollowerUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = FollowerAvatarImageView(frame: .zero)
    let usernameLabel = FollowersTitleLabel(textAligment: .left, fontSize: 34)
    let nameLabel = FollowerSecondaryTitleLabel(fontSize: 18)
    let locationLabel = FollowerSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let bioLabel = FollowersBodyLabel(textAligment: .left)
    
    var user: User?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateUIElements()
    }
    
    private func updateUIElements() {
        usernameLabel.text = user?.login
        nameLabel.text = user?.name ?? "No name"
        locationLabel.text = user?.location ?? "No location"
        bioLabel.text = user?.bio ?? "No bio"
        locationImageView.image = SFSymbols.location
        avatarImageView.setImage(avatar: user?.avatar)
    }

    private func configure() {
        view.setAvatarImageView(view: view, image: avatarImageView)
        view.setUsernameLabel(view: view, label: usernameLabel, image: avatarImageView)
        view.setNameLabel(view: view, label: nameLabel, image: avatarImageView)
        view.setLocationImageView(view: view, image: locationImageView, avatar: avatarImageView)
        view.setLocationLabel(view: view, label: locationLabel, image: locationImageView)
        view.setBioLabel(view: view, label: bioLabel, image: avatarImageView)
    }

}
