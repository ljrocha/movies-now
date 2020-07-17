//
//  MNLabel.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/2/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNLabel: UILabel {

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textStyle: UIFont.TextStyle, textAlignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        
        self.font = UIFont.preferredFont(forTextStyle: textStyle)
        self.adjustsFontForContentSizeCategory = true
        self.textAlignment = textAlignment
    }
    
    convenience init(fontSize: CGFloat, weight: UIFont.Weight, textAlignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textAlignment = textAlignment
    }
    
    // MARK: - Private methods
    
    private func configure() {
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }

}
