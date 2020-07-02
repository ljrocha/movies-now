//
//  MNMovieInfoView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/1/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNMovieInfoView: UIView {
    
    let titleLabel = UILabel(frame: .zero)
    let dateLabel = UILabel(frame: .zero)
    let overviewTitleLabel = UILabel(frame: .zero)
    let overviewLabel = UILabel(frame: .zero)
    let genreTitleLabel = UILabel(frame: .zero)
    let genreLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(overviewTitleLabel)
        addSubview(overviewLabel)
        addSubview(genreTitleLabel)
        addSubview(genreLabel)
        
        backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewTitleLabel.text = "Overview"
        overviewTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        overviewTitleLabel.adjustsFontForContentSizeCategory = true
        overviewTitleLabel.numberOfLines = 0
        overviewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabel.font = UIFont.preferredFont(forTextStyle: .body)
        overviewLabel.adjustsFontForContentSizeCategory = true
        overviewLabel.numberOfLines = 0
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        genreTitleLabel.text = "Genre"
        genreTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        genreTitleLabel.adjustsFontForContentSizeCategory = true
        genreTitleLabel.numberOfLines = 0
        genreTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        genreLabel.font = UIFont.preferredFont(forTextStyle: .body)
        genreLabel.adjustsFontForContentSizeCategory = true
        genreLabel.numberOfLines = 0
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
