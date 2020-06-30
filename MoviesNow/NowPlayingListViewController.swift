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
    
    var movies: [Movie] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureCollectionView()
        configureDataSource()
        
        getMovies()
    }
    
    func getMovies() {
        let baseURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=d9849a7a8ca5063953c590dc110d6874"
        let url = URL(string: baseURLString)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            if let data = data, let movieResponse = try? jsonDecoder.decode(MovieResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.movies = movieResponse.results
                    self.updateMovies()
                }
            } else {
                print("Either no data was found, or data was not properly decoded.")
                return
            }
        }
        task.resume()
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
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5 + 40)
        
        return flowLayout
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
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
