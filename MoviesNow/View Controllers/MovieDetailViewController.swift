//
//  MovieDetailViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieDetailViewController: MNDataLoadingViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let imageView = UIImageView(frame: .zero)
    let movieInfoView = MNMovieInfoView(frame: .zero)
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureImageView()
        configureScrollView()
        fetchMovieBackdropImage()
        setupUI()
    }
    
    func fetchMovieBackdropImage() {
        MovieStore.shared.fetchBackdropImage(for: movie, size: .large) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    @objc func addTapped() {
        PersistenceManager.updateWith(favorite: movie, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard error == nil else {
                self.presentAlertOnMainThread(title: "Something went wrong...", message: error!.rawValue, buttonTitle: "OK")
                return
            }
            
            self.presentAlertOnMainThread(title: "Success!", message: "You have successfully added this movie to your favorites", buttonTitle: "OK")
        }
    }
    
    private func configureViewController() {
        title = movie.title
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
        ])
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        
        scrollView.contentInset = UIEdgeInsets(top: view.frame.width / 2, left: 0, bottom: 0, right: 0)
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
    
    private func setupUI() {
        stackView.addArrangedSubview(movieInfoView)
        movieInfoView.set(movie: movie)
        
        let movieCastViewController = MNMovieCastViewController()
        movieCastViewController.movie = movie
        addChild(movieCastViewController)
        stackView.addArrangedSubview(movieCastViewController.view)
        movieCastViewController.didMove(toParent: self)
    }
    
}
