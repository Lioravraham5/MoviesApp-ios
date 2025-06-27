//
//  File.swift
//  MoviesApp
//
//  Created by Student17 on 27/06/2025.
//

import Foundation

protocol MovieListFetchDelegate: AnyObject {
    func didReceiveMovies(_ movieAPIManager: MovieAPIManager, movies: [MovieFullDetails])
    func didFailWithError(error: Error)
}

protocol MovieFetchDelegate: AnyObject {
    func didReceiveMovie(_ movieAPIManager: MovieAPIManager, movie: MovieFullDetails)
    func didFailWithError(error: Error)
}

class MovieAPIManager {
    private let baseURL = "https://api.themoviedb.org/3"
    
    private let apiKey: String = {
        return Bundle.main.object(forInfoDictionaryKey: "MOVIES_API_KEY") as? String ?? ""
    }() // () mean the the closure run immedeately
    
    weak var movieListFetchDelegate: MovieListFetchDelegate?
    weak var movieFetchDelegate: MovieFetchDelegate?
    
    // MARK: - Public methods:
    func fetchPopularMovies() {
        let url = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        performMovieListRequest(with: url)
    }
    
    func fetchTopRatedMovies() {
        let url = "\(baseURL)/movie/top_rated?api_key=\(apiKey)"
        performMovieListRequest(with: url)
    }
    
    func fetchUpcomingMovies() {
        let url = "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
        performMovieListRequest(with: url)
    }
    
    func fetchMoviesByGenre(genreID: Int){
        let url = "\(baseURL)/discover/movie?api_key=\(apiKey)&sort_by=popularity.desc&with_genres=\(genreID)"
        performMovieListRequest(with: url)
    }
    
    func fetchMovieByID(movieID: Int){
        let url = "\(baseURL)/movie/\(movieID)?api_key=\(apiKey)"
        performSpecficMovieRequest(with: url)
    }
    
    // MARK: - Private methods:
    private func performMovieListRequest(with urlString: String) {
        
    }
    
    private func performSpecficMovieRequest(with urlString: String) {
        
    }
    
}
