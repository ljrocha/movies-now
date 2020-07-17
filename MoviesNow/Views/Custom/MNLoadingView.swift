//
//  MNLoadingView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/10/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNLoadingView: UIView {
    
    // MARK: - Properties
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configure() {
        addSubview(activityIndicator)
        
        backgroundColor = .systemBackground
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }

}
