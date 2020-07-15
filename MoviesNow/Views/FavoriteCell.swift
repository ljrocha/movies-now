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
    
    let movieImageView = UIImageView(frame: .zero)
    let titleLabel = MNLabel(fontSize: 18, weight: .semibold)
    let genreLabel = MNLabel(fontSize: 10, weight: .light)
    let dateLabel = MNLabel(fontSize: 10, weight: .light)
    let descriptionLabel = MNLabel(fontSize: 12, weight: .regular)
    
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
        
        MovieStore.shared.fetchPosterImage(for: movie, size: .small) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    
    // MARK: - Private methods
    
    private func configure() {
        contentView.addSubviews(movieImageView, titleLabel, genreLabel, dateLabel, descriptionLabel)
        
        movieImageView.layer.borderColor = UIColor.systemGray.cgColor
        movieImageView.layer.borderWidth = 0.5
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.numberOfLines = 3
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.5),
            movieImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: padding),
            movieImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 1.5),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            genreLabel.heightAnchor.constraint(equalToConstant: 14),
            
            dateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 14),
            
            descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(padding * 1.5))
        ])
    }

}
