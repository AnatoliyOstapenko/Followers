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
        dismissKeyboardTapGesture()
        usernameTextField.delegate = self

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
        setCallToActionButton()
    }
    
    func setCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpOutside)

    }
    
    func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        let followerListVC = FollowerListViewController()
        followerListVC.username = usernameTextField.text
        followerListVC.title = (usernameTextField.text)?.uppercased()
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return button pressed")
        pushFollowerListVC()
        return true
    }
}
