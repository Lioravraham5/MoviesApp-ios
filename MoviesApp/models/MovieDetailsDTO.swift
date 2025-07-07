//
//  MovieDetailsDTO.swift
//  MoviesApp
//
//  Created by Student17 on 02/07/2025.
//

// DTO - Data Transfer Object
struct Genre: Decodable {
    let id: Int
    let name: String
}

struct MovieDetailsDTO: Decodable {
    let id: Int
    let original_title: String
    let poster_path: String
    let overview: String
    let vote_average: Double
    let release_date: String
    let runtime: Int // Movie duration in minutes
    let genres: [Genre]
    
    var genresDisplayString: String {
        genres.map { $0.name } // Iterate in each genre in genres and return new array of genre names
            .joined(separator: ", ") // Combines all genre names into a single string with commas between them
    }
}
