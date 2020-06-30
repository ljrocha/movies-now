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
    let titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        titleLabel.text = movie.title
        
        guard let imagePath = movie.image else { return }
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let url = URL(string: baseURLString + imagePath)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                print("Either no data was found, or data was not properly decoded.")
                return
            }
        }
        task.resume()
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 0
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
}
