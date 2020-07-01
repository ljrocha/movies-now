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
    let posterImagePath: String?
    let backdropImagePath: String?
    let voteAverage: Double
    
    var genresString: String {
        return genres.compactMap { genresDict[$0] }
            .joined(separator: genres.count == 2 ? " & " : ", ")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case adult
        case genres = "genre_ids"
        case posterImagePath = "poster_path"
        case backdropImagePath = "backdrop_path"
        case voteAverage = "vote_average"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

fileprivate let genresDict: [Int: String] = [
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
]
