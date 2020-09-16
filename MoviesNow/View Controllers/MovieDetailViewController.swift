//
//  MovieDetailViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let backdropImageView = MNBackdropImageView(frame: .zero)
    
    var movie: Movie!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureBackdropImageView()
        configureScrollView()
        setupUI()
    }
    
    // MARK: - Methods
    
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
    
    private func configureBackdropImageView() {
        view.addSubview(backdropImageView)
        backdropImageView.downloadImage(forMovie: movie, size: .large)
        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 0.5),
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
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func setupUI() {
        let movieInfoViewController = MNMovieInfoViewController()
        movieInfoViewController.movie = movie
        add(movieInfoViewController)
        
        let castInfoViewController = MNCastInfoViewController()
        castInfoViewController.movie = movie
        add(castInfoViewController)
    }
    
    private func add(_ child: UIViewController) {
        addChild(child)
        stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
}
