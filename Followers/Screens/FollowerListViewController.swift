//
//  FollowerListViewController.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 15.04.2022.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
