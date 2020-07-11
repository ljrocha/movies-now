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
    var emptyStateView: MNEmptyStateView!
    
    func showLoadingView() {
        loadingView = MNLoadingView(frame: view.bounds)
        view.addSubview(loadingView)
        
        loadingView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.loadingView.alpha = 0.8
        }
    }
    
    func showEmptyStateView(message: String = "") {
        guard emptyStateView == nil else { return }
        
        emptyStateView = MNEmptyStateView(frame: view.bounds)
        emptyStateView.messageLabel.text = message
        view.addSubview(emptyStateView)
        
        emptyStateView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.emptyStateView.alpha = 0.8
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
    
    func dismissEmptyStateView() {
        guard emptyStateView != nil else { return }
        
        DispatchQueue.main.async {
            self.emptyStateView.removeFromSuperview()
            self.emptyStateView = nil
        }
        
    }
    
}
