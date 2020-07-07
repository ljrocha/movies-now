//
//  MNTabBarController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/4/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createTopRatedListNavigationController(), createMovieSearchListNavigationController()]
    }
    
    private func createTopRatedListNavigationController() -> UINavigationController {
        let topRatedViewController = TopRatedListViewController()
        topRatedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        
        return UINavigationController(rootViewController: topRatedViewController)
    }
    
    private func createMovieSearchListNavigationController() -> UINavigationController {
        let movieSearchListViewController = MovieSearchListViewController()
        movieSearchListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: movieSearchListViewController)
    }

}
