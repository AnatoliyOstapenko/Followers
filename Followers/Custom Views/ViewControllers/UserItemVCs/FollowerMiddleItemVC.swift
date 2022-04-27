//
//  FollowerRepoVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 27.04.2022.
//

import UIKit

class FollowerMiddleItemVC: FollowerItemVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        leftItemView.set(itemInfoType: .repos, count: user?.publicRepos ?? 0)
        rightItemView.set(itemInfoType: .gists, count: user?.publicRepos ?? 0)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
