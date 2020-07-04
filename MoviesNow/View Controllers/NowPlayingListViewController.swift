//
//  NowPlayingListViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/29/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class NowPlayingListViewController: MNDataLoadingViewController {

    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    var movies: [Movie] = []
    var page = 1
    var hasMoreDataToLoad = true
    var isLoadingMoreData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        fetchMovies()
    }
    
    func fetchMovies() {
        showLoadingView()
        MovieStore.shared.fetchMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
            }
            
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    if movieResponse.page >= movieResponse.totalPages { self.hasMoreDataToLoad = false }
                    self.movies += movieResponse.results.filter { $0.adult == false }
                    self.updateMovies()
                }
            case .failure(let error):
                // Display error in an alert
                print(error.rawValue)
            }
        }
    }
    
    func updateMovies() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot)
    }
    
    private func configureViewController() {
        title = "Now Playing"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 2)
        
        return flowLayout
    }
    
    @objc func handleRefreshControl() {
        page = 1
        hasMoreDataToLoad = true
        isLoadingMoreData = false
        movies.removeAll()
        updateMovies()
        fetchMovies()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)
            return cell
        }
    }

}

extension NowPlayingListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreDataToLoad, !isLoadingMoreData else { return }
            page += 1
            fetchMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movie = movie
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
