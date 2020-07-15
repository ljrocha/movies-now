//
//  MNMovieInfoViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/13/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNMovieInfoViewController: UIViewController {

    // MARK: - Properties
    
    let titleLabel = MNLabel(textStyle: .title1, textAlignment: .center)
    let dateLabel = MNLabel(textStyle: .caption1, textAlignment: .center)
    let overviewTitleLabel = MNLabel(textStyle: .headline)
    let overviewLabel = MNLabel(textStyle: .body)
    let genreTitleLabel = MNLabel(textStyle: .headline)
    let genreLabel = MNLabel(textStyle: .body)
    let userScoreTitleLabel = MNLabel(textStyle: .headline)
    let userScoreLabel = MNUserScoreLabel()
    
    var movie: Movie!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func configure() {
        let sectionSpacing: CGFloat = 8
        
        let headerStackView = MNStackView(arrangedSubviews: [titleLabel, dateLabel])
        let overviewStackView = MNStackView(arrangedSubviews: [overviewTitleLabel, overviewLabel])
        let genreStackView = MNStackView(arrangedSubviews: [genreTitleLabel, genreLabel])
        let containerStackView = MNStackView(arrangedSubviews: [headerStackView, overviewStackView, genreStackView])
        containerStackView.spacing = sectionSpacing
        
        view.addSubviews(containerStackView, userScoreTitleLabel, userScoreLabel)
        view.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        view.layer.cornerRadius = 10
        
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            userScoreTitleLabel.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: sectionSpacing),
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
        userScoreLabel.set(rating: movie.ratingPercentage)
    }

}
