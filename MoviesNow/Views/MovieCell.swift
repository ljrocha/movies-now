//
//  MovieCell.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/29/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "MovieCell"
    
    let imageView = MNPosterImageView(frame: .zero)
    let titleLabel = MNLabel(fontSize: 12, weight: .semibold, textAlignment: .center)
    let genreLabel = MNLabel(fontSize: 10, weight: .light, textAlignment: .center)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func set(movie: Movie) {
        titleLabel.text = movie.title
        genreLabel.text = movie.genresString
        
        MovieStore.shared.fetchPosterImage(for: movie, size: .small) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    // MARK: - Private methods
    
    private func configure() {
        contentView.addSubviews(imageView, titleLabel, genreLabel)
        
        genreLabel.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genreLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}
