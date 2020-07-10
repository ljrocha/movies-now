//
//  MovieSearchListViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/4/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieSearchListViewController: MovieListViewController {
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        navigationItem.largeTitleDisplayMode = .never
        configureSearchBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchBar.resignFirstResponder()
    }
    
    override func fetchMovies() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        showLoadingView()
        isLoadingMoreData = true
        
        MovieStore.shared.fetchMovies(forSearchTerm: searchTerm, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    if movieResponse.page >= movieResponse.totalPages { self.hasMoreDataToLoad = false }
                    self.movies.append(contentsOf: movieResponse.results)
                    self.updateMovies()
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong...", message: error.rawValue, buttonTitle: "OK")
            }
            
            self.isLoadingMoreData = false
        }
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "Search for movie"
        searchBar.keyboardType = .webSearch
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
}

extension MovieSearchListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        movies.removeAll()
        updateMovies()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        
        page = 1
        hasMoreDataToLoad = true
        isLoadingMoreData = false
        movies.removeAll()
        updateMovies()
        fetchMovies()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        
        searchBar.text = ""
        movies.removeAll()
        updateMovies()
    }
}
