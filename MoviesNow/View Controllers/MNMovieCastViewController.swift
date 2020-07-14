//
//  MNMovieCastViewController.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/13/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNMovieCastViewController: MNDataLoadingViewController {

    let castTitleLabel = MNLabel(textStyle: .headline)
    let castMembersLabel = MNLabel(textStyle: .body)
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        fetchCastMembers()
    }
    
    private func configure() {
        view.addSubviews(castTitleLabel, castMembersLabel)
        view.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        view.layer.cornerRadius = 10
        
        castTitleLabel.text = "Cast"
        
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            castTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            castTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            castTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            castMembersLabel.topAnchor.constraint(equalTo: castTitleLabel.bottomAnchor, constant: 3),
            castMembersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            castMembersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            castMembersLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
    }
    
    func fetchCastMembers() {
        showLoadingView()
        MovieStore.shared.fetchCastMembers(for: movie) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let castMembers):
                DispatchQueue.main.async {
                    self.set(castMembers: castMembers)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong...", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func set(castMembers: [CastMember]) {
        castMembersLabel.text = castMembers.map { $0.name }
            .joined(separator: "\n")
    }

}
