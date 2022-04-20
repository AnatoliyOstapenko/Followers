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
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource <Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setFollowers(username: username ?? "", page: page)
        setCollectionView()
        configuDataSource()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setFollowers(username: String, page: Int) {
        // Invoke singletone
        NetworkManager.shared.getFollowers(with: username, page: page) { [weak self] result in
            switch result {
            case .success(let followers):
                if followers.count < 100 { self?.hasMoreFollowers = false }
                self?.followers = followers
                self?.updateData()
            case .failure(let error):
                self?.presentFollowersAlertOnMainThread(title: "Warning", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: view.setThreeColumnFlowLayout(view: view))
        view.configureCollectionView(view: view, collectionView: collectionView)
        collectionView.delegate = self
    }
    
    func configuDataSource() {
        dataSource = UICollectionViewDiffableDataSource <Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.setFollower(follower: follower)
            return cell
        })
    }
    
    func updateData() {
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
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers == true else { return }
            page += 1
            setFollowers(username: username ?? "", page: page)
            
        }
        
    }
}
