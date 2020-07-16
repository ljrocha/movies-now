//
//  FavoriteCell.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/8/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "FavoriteCell"
    
    let posterImageView = MNPosterImageView(frame: .zero)
    let titleLabel = MNLabel(textStyle: .headline)
    let genreLabel = MNLabel(textStyle: .caption2)
    let dateLabel = MNLabel(textStyle: .caption2)
    let descriptionLabel = MNLabel(textStyle: .body)
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func set(movie: Movie) {
        titleLabel.text = movie.title
        genreLabel.text = movie.genresString
        dateLabel.text = movie.formattedDate
        descriptionLabel.text = movie.description
        posterImageView.downloadImage(forMovie: movie, size: .small)
    }
    
    // MARK: - Private methods
    
    private func configure() {
        let innerStackView = MNStackView(arrangedSubviews: [titleLabel, genreLabel, dateLabel])
        let outerStackView = MNStackView(arrangedSubviews: [innerStackView, descriptionLabel])
        contentView.addSubviews(posterImageView, outerStackView)
        
        descriptionLabel.numberOfLines = 2
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: 80),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),
            posterImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: padding),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -padding),
            
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 1.5),
            outerStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(padding * 1.5))
        ])
    }

}
