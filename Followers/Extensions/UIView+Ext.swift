//
//  UIView+Ext.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 13.04.2022.
//

import Foundation
import UIKit

fileprivate var padding: CGFloat = 20
fileprivate var paddingDozen: CGFloat = 12

extension UIView {
    
    func configureLogoImageView(view: UIView, imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoPositive")
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureUserTextField(view: UIView, textField: FollowersTextField, imageView: UIImageView) {
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    func configureCallToActionButton(view: UIView, button: UIButton) {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureContainerView(view: UIView, container: UIView) {
        view.addSubview(container)
        container.layer.cornerRadius = 16
        container.layer.borderWidth = 2
        container.layer.borderColor = UIColor.white.cgColor
        container.backgroundColor = .systemBackground
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 280),
            container.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel(container: UIView, label: UILabel, alert: String?) {
        container.addSubview(label)
        label.text = alert ?? "Warning"
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton(container: UIView, button: UIButton, title: String?) {
        container.addSubview(button)
        button.setTitle(title ?? "DONE", for: .normal)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configureMessageLabel(container: UIView, message: UILabel, body: String?, title: UILabel, button: UIButton) {
        container.addSubview(message)
        message.text = body ?? "Unable to complete request"
        message.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            message.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -paddingDozen),
            message.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            message.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureFollowerCell(view: UIView, image: UIImageView, label: UILabel) {
        view.addSubview(image)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: paddingDozen),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            label.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    func configureCollectionView(view: UIView, collectionView: UICollectionView) {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
    }
    
    func setThreeColumnFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12 // Distance between screen bound and icon bound
        let minimumItemSpacing: CGFloat = 10 // Distance between screen bounds
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    func setMessageLabel(view: UIView, label: UILabel) {
        view.addSubview(label)
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            label.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setLogoImageView(view: UIView, imageView: UIImageView, label: UILabel) {
        view.addSubview(imageView)
        imageView.image = UIImage(named: "symbolPositive")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40)
        ])
    }
    
    func setAvatarImageView(view: UIView, image: UIImageView) {
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            image.widthAnchor.constraint(equalToConstant: 90),
            image.heightAnchor.constraint(equalTo: image.widthAnchor)
        ])
    }
    
    func setUsernameLabel(view: UIView, label: UILabel, image: UIImageView) {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: image.topAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: paddingDozen),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func setNameLabel(view: UIView, label: UILabel, image: UIImageView) {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: paddingDozen),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setLocationImageView(view: UIView, image: UIImageView, avatar: UIImageView) {
        view.addSubview(image)
        image.tintColor = .secondaryLabel
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.bottomAnchor.constraint(equalTo: avatar.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: padding),
            image.widthAnchor.constraint(equalToConstant: 20),
            image.heightAnchor.constraint(equalTo: image.widthAnchor)
        ])
    }
    
    func setLocationLabel(view: UIView, label: UILabel, image: UIImageView) {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setBioLabel(view: UIView, label: UILabel, image: UIImageView) {
        view.addSubview(label)
        label.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: paddingDozen),
            label.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            label.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureHeaderView(view: UIView, headerView: UIView) {
        view.addSubview(headerView)
        headerView.backgroundColor = .systemPink
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
