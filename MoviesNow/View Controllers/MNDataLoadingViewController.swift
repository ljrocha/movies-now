//
//  MNDataLoadingViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/2/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNDataLoadingViewController: UIViewController {

    var loadingView: MNLoadingView!
    
    func showLoadingView() {
        loadingView = MNLoadingView(frame: view.bounds)
        view.addSubview(loadingView)
        
        loadingView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.loadingView.alpha = 0.8
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
    
}
