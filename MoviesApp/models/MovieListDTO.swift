//
//  MovieListDTO.swift
//  MoviesApp
//
//  Created by Student17 on 02/07/2025.
//

// DTO - Data Transfer Object

struct MovieListResponse: Decodable  {
    let results: [MovieListDTO]
}

struct MovieListDTO: Decodable {
    let id: Int
    let original_title: String
    let poster_path: String
    let overview: String
    let vote_average: Double
    let release_date: String
    let genre_ids: [Int]
}
