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
}

enum PosterSize: String {
    case small = "w154"
    case medium = "w342"
    case large = "w500"
}

enum BackdropSize: String {
    case small = "w300"
    case medium = "w780"
    case large = "w1280"
}

struct TMDbAPI {
    
    private static let baseURLString = "https://api.themoviedb.org/3/"
    private static let imageBaseURLString = "https://image.tmdb.org/t/p/"
    private static let apiKey = "d9849a7a8ca5063953c590dc110d6874"
    
    private static func url(for endpoint: Endpoint, appendingPath path: String?, parameters: [String: String]? = nil) -> URL {
        let path = path ?? ""
        var components = URLComponents(string: baseURLString + endpoint.rawValue + path)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParameters = [
            "api_key": apiKey
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
    
    static var nowPlayingMoviesURL: URL {
        return url(for: .movies, appendingPath: "now_playing")
    }
    
    static func posterURL(path: String, size: PosterSize) -> URL {
        return URL(string: imageBaseURLString + size.rawValue + path)!
    }
    
    static func backdropURL(path: String, size: BackdropSize) -> URL {
        return URL(string: imageBaseURLString + size.rawValue + path)!
    }
    
    static func movieCastMembersURL(movieID: Int) -> URL {
        return url(for: .movies, appendingPath: "\(movieID)/credits")
    }
    
}
