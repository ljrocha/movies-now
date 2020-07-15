//
//  MovieDetailViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieDetailViewController: MNDataLoadingViewController {
    
    // MARK: - Properties
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let imageView = UIImageView(frame: .zero)
    
    var movie: Movie!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureImageView()
        configureScrollView()
        fetchMovieBackdropImage()
        setupUI()
    }
    
    // MARK: - Methods
    
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
    
    // MARK: - Private methods
    
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
        
        scrollView.contentInset = UIEdgeInsets(top: view.frame.width / 2, left: 0, bottom: 10, right: 0)
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
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func setupUI() {
        let movieInfoViewController = MNMovieInfoViewController()
        movieInfoViewController.movie = movie
        addChild(movieInfoViewController)
        stackView.addArrangedSubview(movieInfoViewController.view)
        movieInfoViewController.didMove(toParent: self)
        
        let castInfoViewController = MNCastInfoViewController()
        castInfoViewController.movie = movie
        addChild(castInfoViewController)
        stackView.addArrangedSubview(castInfoViewController.view)
        castInfoViewController.didMove(toParent: self)
    }
    
}
