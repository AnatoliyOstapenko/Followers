//
//  FollowerAvatarImageView.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 19.04.2022.
//

import UIKit

class FollowerAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
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
        //cache staff: if images already been downloaded, set images from cache
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self?.cache.setObject(image, forKey: cacheKey) // add images to cache
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }

}
