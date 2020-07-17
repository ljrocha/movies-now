//
//  MNBackdropImageView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/16/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNBackdropImageView: UIImageView {

    // MARK: - Properties
    
    let placeholderImage = UIImage(named: "placeholder")
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func downloadImage(forMovie movie: Movie, size: BackdropImageSize) {
        image = placeholderImage
        MovieStore.shared.fetchBackdropImage(for: movie, size: size) { [weak self] image in
            guard let self = self, let image = image else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    // MARK: - Private methods
    
    private func configure() {
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }

}
