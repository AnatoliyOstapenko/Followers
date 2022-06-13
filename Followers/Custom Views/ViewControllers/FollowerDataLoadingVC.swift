//
//  FollowerDataLoadingVC.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 04.05.2022.
//

import UIKit

class FollowerDataLoadingVC: UIViewController {
    
    var containerView: UIView!

    func spinnerActivated() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.7) { self.containerView.alpha = 0.5 }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.color = .label
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func spinnerDeactivated() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(view: UIView, message: FollowerError) {
        let emptyStateView = FollowerEmptyStateView(message: .noFollowers)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
