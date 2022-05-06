//
//  FollowerItemVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 27.04.2022.
//

import UIKit

class FollowerItemVC: UIViewController {
    
    let stackView = UIStackView()
    let leftItemView = FollowerItemView()
    let rightItemView = FollowerItemView()
    let actionButton = FollowersButton()
    
    var user: User?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureActionButton()
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
    
    @objc func actionButtonPressed() {} // add generic action method to be overridden in subclasses

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        view.setStackView(view: view, stack: stackView, leftView: leftItemView, rightView: rightItemView)
        view.setActionButton(view: view, button: actionButton)
    }

}
