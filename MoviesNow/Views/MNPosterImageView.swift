//
//  MNPosterImageView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/15/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNPosterImageView: UIImageView {
    
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
        layer.cornerRadius = 3
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

}
