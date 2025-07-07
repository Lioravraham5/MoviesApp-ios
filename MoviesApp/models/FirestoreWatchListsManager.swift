//
//  FirestoreWatchListsManager.swift
//  MoviesApp
//
//  Created by Student17 on 07/07/2025.
//

import Foundation
import FirebaseFirestore

// MARK: - FirestoreWatchListsManager protocols
protocol FirestoreWatchListWriteDelegate: AnyObject {
    func didAddMovieToWatchlistSuccessfully()
    func didFailToAddMovieToWatchlist(error: Error)
}

protocol FirestoreWatchListReadDelegate: AnyObject {
    func didFetchWatchlistSuccessfully(_ movies: [MovieDetailsDTO])
    func didFailToFetchWatchlist(error: Error)
}

// MARK: - FirestoreWatchListsManager class
class FirestoreWatchListsManager {
    weak var writeDelegate: FirestoreWatchListWriteDelegate?
    weak var readDelegate: FirestoreWatchListReadDelegate?
    
    private let db = Firestore.firestore() // reference to the Cloud firestore (the database)
    private let firebaseAuthManager = FirebaseAuthManager()
    
    func addMovieToWatchList(movie: MovieDetailsDTO) {
        // Ensure that the user is authenticated and get the current user's UID
        guard let userID = firebaseAuthManager.getCurrentUser()?.uid else {
            print("FirestoreWatchListManager: The user didn't authenticate")
            return
        }
        
        // Prepare the movie data to be saved in Firestore
        let movieData: [String: Any] = [
            Constants.FirestoreDB.MovieData.id: movie.id,
            Constants.FirestoreDB.MovieData.originalTitle: movie.original_title,
            Constants.FirestoreDB.MovieData.overview: movie.overview,
            Constants.FirestoreDB.MovieData.posterPath: movie.poster_path,
            Constants.FirestoreDB.MovieData.releaseDate: movie.release_date,
            Constants.FirestoreDB.MovieData.runtime: movie.runtime,
            Constants.FirestoreDB.MovieData.voteAverage: movie.vote_average,
            
            // Convert the genres array of objects into an array of dictionaries
            Constants.FirestoreDB.MovieData.genres: movie.genres.map {
                [Constants.FirestoreDB.MovieData.genreID: $0.id,
                 Constants.FirestoreDB.MovieData.genreName: $0.name]
            }
        ]
        
        // Define the Firestore path: watchlists/{userID}/movies/{movieID}
        
            
        
    }
}
