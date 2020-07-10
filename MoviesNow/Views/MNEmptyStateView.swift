//
//  MNEmptyStateView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/10/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNEmptyStateView: UIView {
    
    let messageLabel = MNLabel(fontSize: 24, weight: .bold, textAlignment: .center)
    let filmImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        
        messageLabel.text = message
    }
    
    private func configure() {
        addSubviews(messageLabel, filmImageView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textColor = .systemGray2
        filmImageView.image = UIImage(systemName: "film")
        filmImageView.tintColor = .systemGray2
        filmImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            filmImageView.widthAnchor.constraint(equalToConstant: 50),
            filmImageView.heightAnchor.constraint(equalToConstant: 50),
            filmImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            filmImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: padding),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -padding)
        ])
    }

}
