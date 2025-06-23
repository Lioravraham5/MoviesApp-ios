//
//  MoviePreview.swift
//  MoviesApp
//
//  Created by Student17 on 23/06/2025.
//

import Foundation

struct MoviePreview {
    let id: Int
    let original_title: String
    let poster_path: String
}

struct MovieFullDetails {
    let id: Int
    let original_title: String
    let poster_path: String
    let overview: String
    let popularity: Double
    let adult: Bool
    let release_date: String
    let genre_ids: [Int]
}
