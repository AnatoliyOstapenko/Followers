//
//  FollowerBottomVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 27.04.2022.
//

import UIKit

class FollowerBottomItemVC: FollowerItemVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        leftItemView.set(itemInfoType: .followers, count: user?.followers ?? 0)
        rightItemView.set(itemInfoType: .following, count: user?.following ?? 0)
        actionButton.set(backgroundColor: .systemCyan, title: "Get Followers")
    }
}
