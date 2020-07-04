//
//  MNCastInfoView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/1/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNCastInfoView: UIView {

    let castTitleLabel = MNLabel(textStyle: .headline)
    let castMembersLabel = MNLabel(textStyle: .body)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(castTitleLabel, castMembersLabel)
        
        backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        castTitleLabel.text = "Cast"
        
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            castTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            castTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            castTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            castMembersLabel.topAnchor.constraint(equalTo: castTitleLabel.bottomAnchor, constant: 3),
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
