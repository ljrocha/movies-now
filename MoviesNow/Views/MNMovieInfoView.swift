//
//  MNMovieInfoView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/1/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNMovieInfoView: UIView {
    
    let titleLabel = MNLabel(textStyle: .title1, textAlignment: .center)
    let dateLabel = MNLabel(textStyle: .caption1, textAlignment: .center)
    let overviewTitleLabel = MNLabel(textStyle: .headline)
    let overviewLabel = MNLabel(textStyle: .body)
    let genreTitleLabel = MNLabel(textStyle: .headline)
    let genreLabel = MNLabel(textStyle: .body)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(titleLabel, dateLabel, overviewTitleLabel, overviewLabel, genreTitleLabel, genreLabel)
        
        backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        overviewTitleLabel.text = "Overview"
        genreTitleLabel.text = "Genre"
        
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            overviewTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 3),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            genreTitleLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            genreTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            genreTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            genreLabel.topAnchor.constraint(equalTo: genreTitleLabel.bottomAnchor, constant: 3),
            genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            genreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    func set(movie: Movie) {
        titleLabel.text = movie.title
        dateLabel.text = movie.formattedDate
        overviewLabel.text = movie.description
        genreLabel.text = movie.genresString
    }
    
}
