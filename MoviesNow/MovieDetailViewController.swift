//
//  MovieDetailViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = UIImageView(frame: .zero)
    let movieInfoView = MNMovieInfoView(frame: .zero)
    var castInfoView = MNCastInfoView(frame: .zero)
    
    var movie: Movie!
    var castMembers: [CastMember] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureScrollView()
        configure()
        fetchMovieBackdropImage()
        fetchCastMembers()
    }
    
    func fetchMovieBackdropImage() {
        MovieStore.shared.fetchBackdropImage(for: movie, size: .large) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func fetchCastMembers() {
        MovieStore.shared.fetchCastMembers(for: movie) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let castMembers):
                DispatchQueue.main.async {
                    self.castMembers = castMembers.filter { $0.profilePath != nil }
                    self.castInfoView.set(castMembers: self.castMembers)
                }
            case .failure(let error):
                // Handle error
                print(error.rawValue)
            }
        }
    }
    
    private func configureViewController() {
        title = movie.title
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.contentInset = UIEdgeInsets(top: view.frame.width / 2, left: 0, bottom: 0, right: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configure() {
        view.addSubview(imageView)
        view.bringSubviewToFront(scrollView)
        contentView.addSubview(movieInfoView)
        contentView.addSubview(castInfoView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            
            movieInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            castInfoView.topAnchor.constraint(equalTo: movieInfoView.bottomAnchor, constant: padding * 2),
            castInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            castInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            castInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        
        movieInfoView.set(movie: movie)
    }

}
