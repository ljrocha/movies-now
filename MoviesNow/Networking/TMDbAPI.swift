//
//  TMDbAPI.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/30/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case movies = "movie/"
    case search = "search/movie"
}

enum PosterImageSize: String {
    case small = "w154"
    case medium = "w342"
    case large = "w500"
}

enum BackdropImageSize: String {
    case small = "w300"
    case medium = "w780"
    case large = "w1280"
}

struct TMDbAPI {
    
    private static let baseURLString = "https://api.themoviedb.org/3/"
    private static let imageBaseURLString = "https://image.tmdb.org/t/p/"
    private static let apiKey = "d9849a7a8ca5063953c590dc110d6874"
    
    // MARK: - Methods
    
    static func topRatedMoviesURL(forPage page: Int) -> URL {
        return url(for: .movies, appendingPath: "top_rated", parameters: ["page": String(page)])
    }
    
    static func movieSearchURL(term: String, forPage page: Int) -> URL {
        return url(for: .search, appendingPath: nil, parameters: ["page": String(page), "query": term, "include_adult": "false"])
    }
    
    static func castMembersURL(movieID: Int) -> URL {
        return url(for: .movies, appendingPath: "\(movieID)/credits")
    }
    
    static func posterImageURL(path: String, size: PosterImageSize) -> URL {
        return URL(string: imageBaseURLString + size.rawValue + path)!
    }
    
    static func backdropImageURL(path: String, size: BackdropImageSize) -> URL {
        return URL(string: imageBaseURLString + size.rawValue + path)!
    }
    
    // MARK: - Private methods
    
    private static func url(for endpoint: Endpoint, appendingPath path: String?, parameters: [String: String]? = nil) -> URL {
        let path = path ?? ""
        var components = URLComponents(string: baseURLString + endpoint.rawValue + path)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParameters = [
            "api_key": apiKey,
            "language": "en-US"
        ]
        
        for (key, value) in baseParameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParameters = parameters {
            for (key, value) in additionalParameters {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
    
}
