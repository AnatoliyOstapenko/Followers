//
//  FollowerAvatarImageView.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 19.04.2022.
//

import UIKit

class FollowerAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "logoPositive")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }

}
