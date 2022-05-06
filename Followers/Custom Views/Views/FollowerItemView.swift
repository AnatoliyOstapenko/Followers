//
//  FollowerItemView.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 25.04.2022.
//

import UIKit

enum ItemInfoType { case repos, gists, followers, following }

class FollowerItemView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = FollowersTitleLabel(textAligment: .left, fontSize: 14)
    let countLabel = FollowersTitleLabel(textAligment: .center, fontSize: 14)
    let testLabel = FollowersBodyLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setSymbolImageView(view: self, imageView: symbolImageView)
        setTitleLabel(view: self, label: titleLabel, symbol: symbolImageView)
        setCountLabel(view: self, label: countLabel, symbol: symbolImageView)
    }
    
    func set(itemInfoType: ItemInfoType, count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
}
