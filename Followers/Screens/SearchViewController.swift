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
    // Computed property to get bool and to check a textfield is empty
    var isUsernameEntered: Bool { return !(usernameTextField.text?.isEmpty ?? false) }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUIElements()
        dismissKeyboardTapGesture()
        usernameTextField.delegate = self
    }
   // hide navbar every time you come to search screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUIElements() {
        view.backgroundColor = .systemBackground // automation change background color depending on iPhone mode
        view.configureLogoImageView(view: view, imageView: logoImageView)
        view.configureUserTextField(view: view, textField: usernameTextField, imageView: logoImageView)
        setCallToActionButton()
    }
    
    func setCallToActionButton() {
        view.configureCallToActionButton(view: view, button: callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
    }
    
    func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        // Check if username is entered
        guard isUsernameEntered else {
            presentFollowersAlertOnMainThread(title: "Warning", message: "Please, type a username.    Don't leave this field empty 🤓", buttonTitle: "Done")
            return }
        
        let followerListVC = FollowerListViewController()
        followerListVC.username = usernameTextField.text
        followerListVC.title = (usernameTextField.text)?.uppercased()
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
