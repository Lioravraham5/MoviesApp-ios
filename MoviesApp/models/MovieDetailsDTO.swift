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
    let runtime: Int
    let genres: [Genre]
}
