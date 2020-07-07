//
//  NowPlayingListViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/29/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class NowPlayingListViewController: MovieListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Now Playing"
        configureRefreshControl()
    }
    
    override func fetchMovies() {
        showLoadingView()
        isLoadingMoreData = true
        
        MovieStore.shared.fetchNowPlayingMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            DispatchQueue.main.async {
                self.collectionView.refreshControl?.endRefreshing()
            }
            
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    if movieResponse.page >= movieResponse.totalPages { self.hasMoreDataToLoad = false }
                    let filteredResults = movieResponse.results.filter { $0.adult == false }
                    self.movies.append(contentsOf: filteredResults)
                    self.updateMovies()
                }
            case .failure(let error):
                // Display error in an alert
                print(error.rawValue)
            }
            
            self.isLoadingMoreData = false
        }
    }
    
    @objc func handleRefreshControl() {
        guard !isLoadingMoreData else { return }
        
        page = 1
        hasMoreDataToLoad = true
        movies.removeAll()
        fetchMovies()
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

}
