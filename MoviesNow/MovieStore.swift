//
//  MovieStore.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieStore {
    
    static let shared = MovieStore()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func fetchMovies(completion: @escaping (Result<[Movie], MNError>) -> Void) {
        let url = TMDbAPI.nowPlayingMoviesURL
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func fetchPosterImage(for movie: Movie, size: PosterSize, completion: @escaping (UIImage?) -> Void) {
        guard let posterImagePath = movie.posterImagePath else {
            completion(nil)
            return
        }
        
        let imageURL = TMDbAPI.posterURL(path: posterImagePath, size: size)
        let cacheKey = NSString(string: imageURL.absoluteString)
        
        if let image = imageCache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }
            
            self.imageCache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
