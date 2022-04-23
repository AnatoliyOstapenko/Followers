//
//  FollowerListViewController.swift
//  Followers
//
//  Created by AnatoliiOstapenko on 15.04.2022.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String?
    var followers: [Follower] = []
    var filtredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource <Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setSearchController()
        setCollectionView()
        configureDataSource()
        setFollowers(username: username ?? "", page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
       }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setFollowers(username: String, page: Int) {
        spinnerActivated()
        // Invoke singletone
        NetworkManager.shared.getFollowers(with: username, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                
                if followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(view: self.view, message: .noFollowers)
                    }
                }
                
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.spinnerDeactivated()
                self.followers.append(contentsOf: followers) // to see first icon on the next page
                self.updateData(followers: self.followers)
            case .failure(let error):
                self.presentAlert(title: "Warning", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    func setSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.hidesSearchBarWhenScrolling = false // resolve bag with disappearing search bar
        navigationItem.searchController = searchController
    }
    
    func setCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: view.setThreeColumnFlowLayout(view: view))
        view.configureCollectionView(view: view, collectionView: collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource <Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.setFollower(follower: follower)
            return cell
        })
    }

    func updateData(followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

// MARK: - Section

extension FollowerListViewController {
    // Enum hashable by default
    enum Section {
        case main
    }
}
// MARK: - UICollectionView Delegate

extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        // Check if user scroll down below last bound of screen:
        if offsetY > contentHeight - height {
            guard hasMoreFollowers == true else { return }
            page += 1
            setFollowers(username: username ?? "", page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filtredFollowers : followers
        let userInfoVC = UserInfoVC()
        userInfoVC.username = activeArray[indexPath.item].login
        let navController = UINavigationController(rootViewController: userInfoVC)
        present(navController, animated: true, completion: nil)

    }
}

// MARK: - Searching

extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filtredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(followers: filtredFollowers)
    }
}

extension FollowerListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(followers: followers)
    }

}

