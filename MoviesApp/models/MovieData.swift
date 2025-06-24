//
//  MoviePreview.swift
//  MoviesApp
//
//  Created by Student17 on 23/06/2025.
//

import Foundation

struct HomeMoviePreview {
    let id: Int
    let original_title: String
    let poster_path: String
}

struct WatchListMoviePreview {
    let id: Int
    let original_title: String
    let poster_path: String
    let genre_ids: [Int]
    let runtime: Int // Movie duration in minutes
    let release_date: String
}

struct MovieFullDetails {
    let id: Int
    let original_title: String
    let poster_path: String
    let overview: String
    let vote_average: Double
    let release_date: String
    let genre_ids: [Int]
    let runtime: Int // Movie duration in minutes
}
