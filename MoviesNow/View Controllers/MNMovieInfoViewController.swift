//
//  MNMovieInfoViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/13/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNMovieInfoViewController: UIViewController {

    let titleLabel = MNLabel(textStyle: .title1, textAlignment: .center)
    let dateLabel = MNLabel(textStyle: .caption1, textAlignment: .center)
    let overviewTitleLabel = MNLabel(textStyle: .headline)
    let overviewLabel = MNLabel(textStyle: .body)
    let genreTitleLabel = MNLabel(textStyle: .headline)
    let genreLabel = MNLabel(textStyle: .body)
    let userScoreTitleLabel = MNLabel(textStyle: .headline)
    let userScoreLabel = MNUserScoreLabel()
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupUI()
    }
    
    private func configure() {
        view.addSubviews(titleLabel, dateLabel, overviewTitleLabel, overviewLabel, genreTitleLabel, genreLabel, userScoreTitleLabel, userScoreLabel)
        view.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        view.layer.cornerRadius = 10
        
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            overviewTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 3),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            genreTitleLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            genreTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            genreTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            genreLabel.topAnchor.constraint(equalTo: genreTitleLabel.bottomAnchor, constant: 3),
            genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            userScoreTitleLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            userScoreTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userScoreTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            userScoreLabel.topAnchor.constraint(equalTo: userScoreTitleLabel.bottomAnchor, constant: 7),
            userScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userScoreLabel.widthAnchor.constraint(equalToConstant: 50),
            userScoreLabel.heightAnchor.constraint(equalToConstant: 50),
            userScoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        ])
    }
    
    private func setupUI() {
        titleLabel.text = movie.title
        dateLabel.text = movie.formattedDate
        overviewTitleLabel.text = "Overview"
        overviewLabel.text = movie.description
        genreTitleLabel.text = "Genre"
        genreLabel.text = movie.genresString
        userScoreTitleLabel.text = "User Score"
        let rating = Int(movie.voteAverage * 10)
        userScoreLabel.set(rating: rating)
    }

}
