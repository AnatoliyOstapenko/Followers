//
//  FollowersAlertViewController.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 16.04.2022.
//

import UIKit

class FollowersAlertViewController: UIViewController {
    
    let containerView = UIView()
    let titleLabel = FollowersTitleLabel(textAligment: .center, fontSize: 20)
    let messageLabel = FollowersBodyLabel(textAligment: .center)
    let actionButton = FollowersButton(backgroundColor: .systemRed, title: "OK")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.configureContainerView(view: view, container: containerView)
        view.configureTitleLabel(container: containerView, label: titleLabel, alert: alertTitle)
        setActionButton()
        view.configureMessageLabel(container: containerView, message: messageLabel, body: message, title: titleLabel, button: actionButton)
    }
    
    func setActionButton() {
        view.configureActionButton(container: containerView, button: actionButton, title: buttonTitle)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }

    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    

}
