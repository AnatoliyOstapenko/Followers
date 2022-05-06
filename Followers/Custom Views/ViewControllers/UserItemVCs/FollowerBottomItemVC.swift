//
//  FollowerBottomVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 27.04.2022.
//

import UIKit

protocol BottomItemDelegate: AnyObject {
    func didTapGetFollowers(user: User)
}

class FollowerBottomItemVC: FollowerItemVC {
    
    weak var bottomDelegate: BottomItemDelegate?
    
    init(user: User, bottomDelegate: BottomItemDelegate) {
        super.init(user: user)
        self.bottomDelegate = bottomDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        leftItemView.set(itemInfoType: .followers, count: user?.followers ?? 0)
        rightItemView.set(itemInfoType: .following, count: user?.following ?? 0)
        actionButton.set(backgroundColor: .systemCyan, title: "Get Followers")
    }
    
    override func actionButtonPressed() {
        guard let user = user else { return }
        bottomDelegate?.didTapGetFollowers(user: user)
    }
}
