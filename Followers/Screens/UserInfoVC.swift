//
//  UserInfoVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 23.04.2022.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var headerView = UIView()
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setBarButtons()
        downloadUser()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = username?.uppercased() ?? ""
        view.configureHeaderView(view: view, headerView: headerView)
    }
    
    func headerChildVC(childVC: UIViewController, containerView: UIView) {
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
                DispatchQueue.main.async {
                    self.headerChildVC(childVC: FollowerUserInfoHeaderVC(user: user), containerView: self.headerView)
                }
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
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
