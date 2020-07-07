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

        viewControllers = [createNowPlayingListNavigationController(), createMovieSearchListNavigationController()]
    }
    
    private func createNowPlayingListNavigationController() -> UINavigationController {
        let nowPlayingListViewController = NowPlayingListViewController()
        nowPlayingListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        return UINavigationController(rootViewController: nowPlayingListViewController)
    }
    
    private func createMovieSearchListNavigationController() -> UINavigationController {
        let movieSearchListViewController = MovieSearchListViewController()
        movieSearchListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: movieSearchListViewController)
    }

}
