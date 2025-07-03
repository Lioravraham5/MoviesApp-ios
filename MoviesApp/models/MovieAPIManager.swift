//
//  File.swift
//  MoviesApp
//
//  Created by Student17 on 27/06/2025.
//

import Foundation

protocol MovieListFetchDelegate: AnyObject {
    func didReceiveMovies(_ movieAPIManager: MovieAPIManager, movies: [MovieListDTO], category: MovieCategory)
    func didFailWithError(error: Error, category: MovieCategory)
}

protocol MovieFetchDelegate: AnyObject {
    func didReceiveMovie(_ movieAPIManager: MovieAPIManager, movie: MovieDetailsDTO)
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
        performMovieListRequest(with: url, category: .popular)
    }
    
    func fetchTopRatedMovies() {
        let url = "\(baseURL)/movie/top_rated?api_key=\(apiKey)"
        performMovieListRequest(with: url, category: .topRated)
    }
    
    func fetchUpcomingMovies() {
        let url = "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
        performMovieListRequest(with: url, category: .upcoming)
    }
    
//    func fetchMoviesByGenre(genreID: Int){
//        let url = "\(baseURL)/discover/movie?api_key=\(apiKey)&sort_by=popularity.desc&with_genres=\(genreID)"
//        performMovieListRequest(with: url)
//    }
    
    func fetchMovieByID(movieID: Int){
        let url = "\(baseURL)/movie/\(movieID)?api_key=\(apiKey)"
        performSpecficMovieRequest(with: url)
    }
    
    // MARK: - Private methods:
    private func performMovieListRequest(with urlString: String, category: MovieCategory) {
        // 1. Create a URL
        if let url = URL(string: urlString){
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default) // the urlSesssion will used us like the browser in chrom
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.movieListFetchDelegate?.didFailWithError(error: error!, category: category)
                    return
                }
                
                if let safeData = data {
                    if let movies = self.parseJSONToMovieList(safeData, category) {
                        self.movieListFetchDelegate?.didReceiveMovies(self, movies: movies, category: category)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
        
    }
    
    private func parseJSONToMovieList(_ moviesListData: Data, _ category: MovieCategory) -> [MovieListDTO]? {
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(MovieListResponse.self, from: moviesListData)
            return decodeData.results
        }
        catch{
            movieListFetchDelegate?.didFailWithError(error: error, category: category)
            return nil
        }
        
    }
    
    private func performSpecficMovieRequest(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString){
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default) // the urlSesssion will used us like the browser in chrom
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.movieFetchDelegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let movie = self.parseJSONToMovie(safeData) {
                        self.movieFetchDelegate?.didReceiveMovie(self, movie: movie)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
        
    }
    
    private func parseJSONToMovie(_ movieData: Data) -> MovieDetailsDTO? {
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(MovieDetailsDTO.self, from: movieData)
            return decodeData
        }
        catch{
            movieFetchDelegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
