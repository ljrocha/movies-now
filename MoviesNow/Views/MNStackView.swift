//
//  MNStackView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/15/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
    }

}
