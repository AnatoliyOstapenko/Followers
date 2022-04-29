//
//  UserInfoVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 23.04.2022.
//

import UIKit
import SafariServices

protocol UserInfoDelegate: AnyObject {
    func didTapGitHubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class UserInfoVC: UIViewController {
    
    var headerContainer = UIView()
    var middleContainer = UIView()
    var bottomContainer = UIView()
    var dateLabel = FollowersBodyLabel(textAligment: .center)
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setBarButtons()
        downloadUser()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.configureHeaderContainer(view: view, container: headerContainer)
        view.setNextContainer(view: view, container: middleContainer, topContainer: headerContainer)
        view.setNextContainer(view: view, container: bottomContainer, topContainer: middleContainer)
        view.setDateLabel(view: view, label: dateLabel, topContainer: bottomContainer)
    }
    
    func addChildVC(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func downloadUser() {
        NetworkManager.shared.getUserInfo(with: username ?? "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.successUser(user: user) }
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func successUser(user: User) {
        let middleItemVC = FollowerMiddleItemVC(user: user)
        middleItemVC.delegate = self
        let bottomItemVC = FollowerBottomItemVC(user: user)
        bottomItemVC.delegate = self
        
        self.addChildVC(childVC: FollowerUserInfoHeaderVC(user: user), containerView: self.headerContainer)
        self.addChildVC(childVC: middleItemVC, containerView: self.middleContainer)
        self.addChildVC(childVC: bottomItemVC, containerView: self.bottomContainer)
        self.dateLabel.text = user.createdAt.convertToDisplay()
    }
    
    private func setBarButtons() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(sender:)))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func done(sender: Any) {
        
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UserInfo Delegate

extension UserInfoVC: UserInfoDelegate {
    
    func didTapGitHubProfile(user: User) {
        guard let url = URL(string: user.htmlURL) else {
            presentAlert(title: "Warning", message: "URL attached to this user is invalid 🦄", buttonTitle: "Ok")
            return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemRed
        present(safariVC, animated: true, completion: nil)
        
    }
    
    func didTapGetFollowers(user: User) {
        print("")
    }
}
