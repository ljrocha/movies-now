//
//  MovieCell.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/29/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseID = "MovieCell"
    
    let imageView = UIImageView(frame: .zero)
    let titleLabel = MNLabel(fontSize: 12, weight: .semibold, textAlignment: .center)
    let genreLabel = MNLabel(fontSize: 10, weight: .light, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func configure() {
        contentView.addSubviews(imageView, titleLabel, genreLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false        
        genreLabel.numberOfLines = 1
        
        let padding: CGFloat = 0
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            genreLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}