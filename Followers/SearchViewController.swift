//
//  SearchViewController.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 13.04.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = FollowersTextField()
    let callToActionButton = FollowersButton(backgroundColor: .systemRed, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // automation change background color depending on iPhone mode
        setUIElements()

    }
   // hide navbar by viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func setUIElements() {
        view.configureLogoImageView(view: view, imageView: logoImageView)
        view.configureUserTextField(view: view, textField: usernameTextField, imageView: logoImageView)
        view.configureCallToActionButton(view: view, button: callToActionButton)
    }
    
    

}
