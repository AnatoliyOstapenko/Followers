//
//  UIViewController+Ext.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 16.04.2022.
//

import UIKit

extension UIViewController {
    
    func presentFollowersAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = FollowersAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
