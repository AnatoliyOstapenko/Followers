//
//  UserInfoVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 23.04.2022.
//

import UIKit

protocol UserInfoDelegate: AnyObject {
    func didRequestFollowers(username: String)
}

class UserInfoVC: FollowerDataLoadingVC {
    
    var headerContainer = UIView()
    var middleContainer = UIView()
    var bottomContainer = UIView()
    var dateLabel = FollowersBodyLabel(textAligment: .center)
    var username: String?
    weak var userInfodelegate: UserInfoDelegate?

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
        spinnerActivated()
        NetworkManager.shared.getUserInfo(with: username ?? "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.successUser(user: user)
                    self.spinnerDeactivated()
                }
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func successUser(user: User) {
        self.addChildVC(childVC: FollowerUserInfoHeaderVC(user: user), containerView: headerContainer)
        self.addChildVC(childVC: FollowerMiddleItemVC(user: user, middleDelegate: self), containerView: middleContainer)
        self.addChildVC(childVC: FollowerBottomItemVC(user: user, bottomDelegate: self), containerView: bottomContainer)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToString())"
    }
    
    private func setBarButtons() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(sender:)))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func done(sender: Any) {
        dismiss(animated: true, completion: nil) // TODO: - to being changed further
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - MidleItemDelegate
extension UserInfoVC: MidleItemDelegate {
    
    func didTapGitHubProfile(user: User) {
        // Open Safari page related to user htmlURL
        guard let url = URL(string: user.htmlURL) else {
            presentAlert(title: "Invalid URL", message: "URL attached to this user is invalid 🦄", buttonTitle: "Ok")
            return
        }
        presentSafariVC(url: url)
    }
}

// MARK: - BottomItemDelegate
extension UserInfoVC: BottomItemDelegate {
    func didTapGetFollowers(user: User) {
        guard user.followers != 0 else {
            presentAlert(title: "No Followers", message: "This user has no followers 🦄", buttonTitle: "OK")
            return
        }
        userInfodelegate?.didRequestFollowers(username: user.login)
        dismiss(animated: true, completion: nil)
    }
}
