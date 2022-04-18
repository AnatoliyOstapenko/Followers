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
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Invoke singletone
        NetworkManager.shared.getFollowers(with: username ?? "", page: 1) { followers, error in
            guard let followers = followers else {
                self.presentFollowersAlertOnMainThread(title: "Warning", message: error ?? "Unable to retreive data", buttonTitle: "OK")
                return
            }
            print("Followers = \(followers.count)")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
