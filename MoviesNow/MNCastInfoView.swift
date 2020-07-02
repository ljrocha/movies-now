//
//  MNCastInfoView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/1/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNCastInfoView: UIView {

    let castLabel = UILabel(frame: .zero)
    let castMembersLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(castLabel)
        addSubview(castMembersLabel)
        
        backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        castLabel.text = "Cast"
        castLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        castLabel.adjustsFontForContentSizeCategory = true
        castLabel.numberOfLines = 0
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        
        castMembersLabel.font = UIFont.preferredFont(forTextStyle: .body)
        castMembersLabel.adjustsFontForContentSizeCategory = true
        castMembersLabel.numberOfLines = 0
        castMembersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            castLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            castLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            castMembersLabel.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 0),
            castMembersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            castMembersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            castMembersLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    func set(castMembers: [CastMember]) {
        castMembersLabel.text = castMembers.map { $0.name }
            .joined(separator: "\n")
    }
}
