//
//  MNTabBarController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/4/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNTabBarController: UITabBarController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createTopRatedListNavigationController(), createMovieSearchListNavigationController(), createFavoritesListNavigationController()]
    }
    
    // MARK: - Private methods
    
    private func createTopRatedListNavigationController() -> UINavigationController {
        let topRatedListViewController = TopRatedListViewController()
        topRatedListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        
        return UINavigationController(rootViewController: topRatedListViewController)
    }
    
    private func createMovieSearchListNavigationController() -> UINavigationController {
        let movieSearchListViewController = MovieSearchListViewController()
        movieSearchListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: movieSearchListViewController)
    }
    
    private func createFavoritesListNavigationController() -> UINavigationController {
        let favoritesListViewController = FavoritesListViewController()
        favoritesListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        return UINavigationController(rootViewController: favoritesListViewController)
    }

}
