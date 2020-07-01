//
//  MovieDetailViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    let imageView = UIImageView(frame: .zero)
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configure()
        fetchMovieBackdropImage()
    }
    
    func fetchMovieBackdropImage() {
        MovieStore.shared.fetchBackdropImage(for: movie, size: .large) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    private func configureViewController() {
        title = movie.title
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configure() {
        view.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5)
        ])
    }

}
