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
        
        MovieStore.shared.fetchPosterImage(for: movie, size: .small) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    
    // MARK: - Private methods
    
    private func configure() {
        let innerStackView = MNStackView(arrangedSubviews: [titleLabel, genreLabel, dateLabel])
        let outerStackView = MNStackView(arrangedSubviews: [innerStackView, descriptionLabel])
        contentView.addSubviews(movieImageView, outerStackView)
        
        movieImageView.layer.borderColor = UIColor.systemGray.cgColor
        movieImageView.layer.borderWidth = 0.5
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.numberOfLines = 2
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 1.5),
            movieImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: padding),
            movieImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -padding),
            
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 1.5),
            outerStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(padding * 1.5))
        ])
    }

}
