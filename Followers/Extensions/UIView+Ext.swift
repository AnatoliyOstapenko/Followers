//
//  UIView+Ext.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 13.04.2022.
//

import Foundation
import UIKit

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
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton(container: UIView, button: UIButton, title: String?) {
        container.addSubview(button)
        button.setTitle(title ?? "DONE", for: .normal)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configureMessageLabel(container: UIView, message: UILabel, body: String?, title: UILabel, button: UIButton) {
        container.addSubview(message)
        message.text = body ?? "Unable to complete request"
        message.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            message.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12),
            message.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            message.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
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
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            label.heightAnchor.constraint(equalToConstant: 20)
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
    
    func setLogoImageView(view: UIView, imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.image = UIImage(named: "symbolPositive")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 200),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 140)
        ])
    }
}
