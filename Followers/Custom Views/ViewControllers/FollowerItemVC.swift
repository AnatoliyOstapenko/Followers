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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.setStackView(view: view, stack: stackView, leftView: leftItemView, rightView: rightItemView)
        view.setActionButton(view: view, button: actionButton)
    }

}
