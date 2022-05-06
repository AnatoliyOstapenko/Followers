//
//  FollowerRepoVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 27.04.2022.
//

import UIKit

protocol MidleItemDelegate: AnyObject {
    func didTapGitHubProfile(user: User)
}

class FollowerMiddleItemVC: FollowerItemVC {
    
    weak var middleDelegate: MidleItemDelegate?
    
    init(user: User, middleDelegate: MidleItemDelegate) {
        super.init(user: user)
        self.middleDelegate = middleDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        leftItemView.set(itemInfoType: .repos, count: user?.publicRepos ?? 0)
        rightItemView.set(itemInfoType: .gists, count: user?.publicRepos ?? 0)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonPressed() {
        guard let user = user else { return }
        middleDelegate?.didTapGitHubProfile(user: user)
    }
}
