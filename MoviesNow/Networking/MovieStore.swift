//
//  MovieStore.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MovieStore {
    
    // MARK: - Properties
    
    static let shared = MovieStore()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Methods
    
    func fetchTopRatedMovies(page: Int, completion: @escaping (Result<MovieResponse, MNError>) -> Void) {
        let url = TMDbAPI.topRatedMoviesURL(forPage: page)
        fetchMovies(url: url, completion: completion)
    }
    
    func fetchMovies(forSearchTerm term: String, page: Int, completion: @escaping (Result<MovieResponse, MNError>) -> Void) {
        let url = TMDbAPI.movieSearchURL(forTerm: term, page: page)
        fetchMovies(url: url, completion: completion)
    }
    
    func fetchCastMembers(for movie: Movie, completion: @escaping (Result<[CastMember], MNError>) -> Void) {
        let url = TMDbAPI.castMembersURL(forMovieID: movie.id)
        
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
                let movieResponse = try decoder.decode(CastMemberResponse.self, from: data)
                completion(.success(movieResponse.cast))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func fetchPosterImage(for movie: Movie, size: PosterImageSize, completion: @escaping (UIImage?) -> Void) {
        guard let posterImagePath = movie.posterImagePath else {
            completion(nil)
            return
        }
        
        let imageURL = TMDbAPI.posterImageURL(forPath: posterImagePath, size: size)
        fetchImage(url: imageURL, completion: completion)
    }
    
    func fetchBackdropImage(for movie: Movie, size: BackdropImageSize, completion: @escaping (UIImage?) -> Void) {
        guard let backdropImagePath = movie.backdropImagePath else {
            completion(nil)
            return
        }
        
        let imageURL = TMDbAPI.backdropImageURL(forPath: backdropImagePath, size: size)
        fetchImage(url: imageURL, completion: completion)
    }
    
    // MARK: - Private methods
    
    private func fetchMovies(url: URL, completion: @escaping (Result<MovieResponse, MNError>) -> Void) {
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
                decoder.dateDecodingStrategy = .formatted(TMDbAPI.dateFormatter)
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    private func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url.absoluteString)
        
        if let image = imageCache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
