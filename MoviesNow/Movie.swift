//
//  Movie.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 6/29/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let description: String
    let releaseDate: String
    let adult: Bool
    let genres: [Int]
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case adult
        case genres = "genre_ids"
        case image = "poster_path"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
