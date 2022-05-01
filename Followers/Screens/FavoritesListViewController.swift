//
//  FavoritesListViewController.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 13.04.2022.
//

import UIKit

class FavoritesListViewController: UIViewController {
    
    let favoriteTablewView = UITableView()
    var favoriteArray: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFavorites()
    }
    
    private func setTableView() {
        view.addSubview(favoriteTablewView)
        favoriteTablewView.frame = view.bounds
        favoriteTablewView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseID)
        favoriteTablewView.dataSource = self
        favoriteTablewView.delegate = self
    }
    
    private func setFavorites() {
        spinnerActivated()
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                DispatchQueue.main.async {
                    self.favoriteArray = favorites
                    self.spinnerDeactivated()
                    self.favoriteTablewView.reloadData()
                }
            case .failure(let error):
                if self.favoriteArray.count ==  0 {
                    self.presentAlert(title: "No followers", message: error.rawValue, buttonTitle: "OK")
                }
                self.presentAlert(title: "Failure", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

}

// MARK: - UITableView DataSource

extension FavoritesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseID, for: indexPath) as! FavoriteTableViewCell
        cell.updateFavoriteCellUI(favorites: favoriteArray[indexPath.row])
        return cell
    }
    
    
}
// MARK: - UITableView DataSource

extension FavoritesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
}
