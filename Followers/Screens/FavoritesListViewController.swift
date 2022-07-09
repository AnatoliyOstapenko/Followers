//
//  FavoritesListViewController.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 13.04.2022.
//

import UIKit

class FavoritesListViewController: FollowerDataLoadingVC {
    
    let favoriteTablewView = UITableView()
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinnerActivated()
        setFavorites()
    }
    
    private func setTableView() {
        view.backgroundColor = .systemBackground
        view.addSubview(favoriteTablewView)
        favoriteTablewView.frame = view.bounds
        favoriteTablewView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseID)
        favoriteTablewView.dataSource = self
        favoriteTablewView.delegate = self
    }
    
    private func setFavorites() {
        spinnerDeactivated()
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.retrieveFavorites(favorites: favorites)
            case .failure(let error):
                self.presentAlert(title: "Failure", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func retrieveFavorites(favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(view: self.view, message: .noFavorites)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.favoriteTablewView.reloadData()
                self.view.bringSubviewToFront(self.favoriteTablewView) // TODO: - Read about it later...
            }
        }
    }
}

// MARK: - UITableView DataSource
extension FavoritesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseID, for: indexPath) as! FavoriteTableViewCell
        cell.updateFavoriteCellUI(favorites: favorites[indexPath.row])
        return cell
    }
    
    
}
// MARK: - UITableView Delegate
extension FavoritesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // transition to followers (FollowerListVC) of chosen user
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let followerVC = FollowerListViewController(username: favorites[indexPath.row].login)
        navigationController?.pushViewController(followerVC, animated: true)
    }
    // remove user from favorites
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let error = error else {
                self?.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return }
            self?.presentAlert(title: "REMOVING", message: error.rawValue, buttonTitle: "OK")
        }
    }
}
