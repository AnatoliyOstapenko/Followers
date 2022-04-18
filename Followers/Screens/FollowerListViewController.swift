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
        setFollowers()
    }
    
    func setFollowers() {
        // Invoke singletone
        NetworkManager.shared.getFollowers(with: username ?? "", page: 1) { [weak self] result in
            switch result {
            case .success(let followers):
                print(followers.count)
            case .failure(let error):
                self?.presentFollowersAlertOnMainThread(title: "Warning", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
