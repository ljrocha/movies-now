//
//  MNLoadingView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/10/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNLoadingView: UIView {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
