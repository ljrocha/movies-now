//
//  NowPlayingListViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/29/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class NowPlayingListViewController: UIViewController {

    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        
        fetchMovies()
    }
    
    func fetchMovies() {
        MovieStore.shared.fetchMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies = movies
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
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movie = movie
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
