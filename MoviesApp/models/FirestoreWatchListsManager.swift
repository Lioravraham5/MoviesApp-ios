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
    func didAddMovieToWatchlistSuccessfully(_ movie: MovieDetailsDTO)
    func didFindMovieAlreadyInWatchlist(_ movie: MovieDetailsDTO)
    func didFailToAddMovieToWatchlist(error: Error)
}

protocol FirestoreWatchListReadDelegate: AnyObject {
    func didFetchWatchlistSuccessfully(_ movies: [MovieDetailsDTO])
    func didFailToFetchWatchlist(error: Error)
}

protocol FirestoreWatchListDeleteDelegate: AnyObject {
    func didDeleteMovieFromWatchlistSuccessfully(movieID: Int)
    func didFailToDeleteMovieFromWatchlist(error: Error)
}

protocol FirestoreWatchListFetchSingleMovieDelegate: AnyObject {
    func didFetchSingleMovieFromWatchlist(_ movie: MovieDetailsDTO)
    func didFailToFetchSingleMovieFromWatchlist(error: Error)
    func didNotFindMovieInWatchlist(movieID: Int)
}

// MARK: - FirestoreWatchListsManager class
class FirestoreWatchListsManager {
    weak var writeDelegate: FirestoreWatchListWriteDelegate?
    weak var readDelegate: FirestoreWatchListReadDelegate?
    weak var deleteDelegate: FirestoreWatchListDeleteDelegate?
    weak var fetchSingleMovieDelegate: FirestoreWatchListFetchSingleMovieDelegate?
    
    private let db = Firestore.firestore() // reference to the Cloud firestore (the database)
    private let firebaseAuthManager = FirebaseAuthManager()
    
    // MARK: - addMovieToWatchList()
    func addMovieToWatchList(movie: MovieDetailsDTO) async {
        Task {
            do {
                // Ensure that the user is authenticated and get the current user's UID
                guard let userID = firebaseAuthManager.getCurrentUser()?.uid else {
                    print("FirestoreWatchListManager: The user didn't authenticate")
                    return
                }
                
                // Define the Firestore document path: watchlists/{userID}/movies/{movieID}
                let movieDocRef = db.collection(Constants.FirestoreDB.watchlists)
                    .document(userID)
                    .collection(Constants.FirestoreDB.movies)
                    .document(String(movie.id))
                
                // Check if the movie already exist
                let documentSnapshot = try await movieDocRef.getDocument()
                if documentSnapshot.exists {
                    writeDelegate?.didFindMovieAlreadyInWatchlist(movie)
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
                    },
                    
                    
                    Constants.FirestoreDB.MovieData.addedAt: FieldValue.serverTimestamp() // Return timestamp from Firebase server
                ]
                
                // Save the movie to Firestore
                try await movieDocRef.setData(movieData)
                writeDelegate?.didAddMovieToWatchlistSuccessfully(movie)
                
            } catch {
                // Handles errors that occourred during the process
                writeDelegate?.didFailToAddMovieToWatchlist(error: error)
            }
            // end Task
        }
        // end function
    }
    
    // MARK: - fetchWatchList()
    func fetchWatchList() {
        Task {
            
            do {
                // Ensure that the user is authenticated and get the current user's UID
                guard let userID = firebaseAuthManager.getCurrentUser()?.uid else {
                    print("FirestoreWatchListManager: The user didn't authenticate")
                    return
                }
                
                // Define the Firestore reference path: atchlists/{userID}/movies and get al documents from it
                let snapshot = try await db.collection(Constants.FirestoreDB.watchlists)
                    .document(userID)
                    .collection(Constants.FirestoreDB.movies)
                    .order(by: Constants.FirestoreDB.MovieData.addedAt, descending: true)
                    .getDocuments()
                
                // Map documents to MovieDetailsDTO array
                let movies: [MovieDetailsDTO] = snapshot
                    .documents // return array of all ducuments that were in the collection [QueryDocumentSnapshot]
                    .compactMap { doc in
                        // Iterate on each doc and try to convert it to MovieDetailsDTO
                        let data = doc.data() // data is the content of the dofcument in [String: Any] format
                        
                        guard let id = data[Constants.FirestoreDB.MovieData.id] as? Int,
                              let original_title = data[Constants.FirestoreDB.MovieData.originalTitle] as? String,
                              let overview = data[Constants.FirestoreDB.MovieData.overview] as? String,
                              let poster_path = data[Constants.FirestoreDB.MovieData.posterPath] as? String,
                              let release_date = data[Constants.FirestoreDB.MovieData.releaseDate] as? String,
                              let runtime = data[Constants.FirestoreDB.MovieData.runtime] as? Int,
                              let vote_average = data[Constants.FirestoreDB.MovieData.voteAverage] as? Double,
                              let genresArray = data[Constants.FirestoreDB.MovieData.genres] as? [[String: Any]] else {
                            print("FirestoreWatchListManager: The convert of the next data to MovieDetailsDTO failed: \(data)")
                            return nil
                        }
                        
                        let genres: [Genre] = genresArray.compactMap { genreDict in
                            // Iterate on each genreDict - [String: Any] and try to convert it to Genre
                            guard let id = genreDict[Constants.FirestoreDB.MovieData.genreID] as? Int,
                                  let name = genreDict[Constants.FirestoreDB.MovieData.genreName] as? String else {
                                print("FirestoreWatchListManager: The convert of the next genreDict to Genre failed: \(genreDict)")
                                return nil
                            }
                            
                            return Genre(id: id, name: name)
                        }
                        return MovieDetailsDTO(id: id,
                                               original_title: original_title,
                                               poster_path: poster_path,
                                               overview: overview,
                                               vote_average: vote_average,
                                               release_date: release_date, runtime: runtime,
                                               genres: genres)
                    }
                
                // Notify delegate that the fetching executed successfully
                readDelegate?.didFetchWatchlistSuccessfully(movies)
                
                
            } catch {
                // Handles errors that occourred during the process
                readDelegate?.didFailToFetchWatchlist(error: error)
            }
            // end task
        }
        // end function
    }
    
    // MARK: - deleteMovieFromWatchlist
    func deleteMovieFromWatchlist(movieID: Int) {
        Task {
            do {
                // Ensure that the user is authenticated and get the current user's UID
                guard let userID = firebaseAuthManager.getCurrentUser()?.uid else {
                    print("FirestoreWatchListManager: The user didn't authenticate")
                    return
                }
                
                // Define the Firestore document path: watchlists/{userID}/movies/{movieID}
                let movieDocRef = db.collection(Constants.FirestoreDB.watchlists)
                    .document(userID)
                    .collection(Constants.FirestoreDB.movies)
                    .document(String(movieID))
                
                // Try to delete the document
                try await movieDocRef.delete()
                deleteDelegate?.didDeleteMovieFromWatchlistSuccessfully(movieID: movieID)
                
            } catch {
                deleteDelegate?.didFailToDeleteMovieFromWatchlist(error: error)
            }
            // end Task
        }
        // end function
    }
    
    
    // MARK: - fetchMovieFromWatchlist()
    func fetchMovieFromWatchlist(movieID: Int) {
        Task {
            do {
                // Ensure that the user is authenticated and get the current user's UID
                guard let userID = firebaseAuthManager.getCurrentUser()?.uid else {
                    print("FirestoreWatchListManager: The user didn't authenticate")
                    return
                }
                
                // Define the Firestore document path: watchlists/{userID}/movies/{movieID}
                let movieDocRef = db.collection(Constants.FirestoreDB.watchlists)
                    .document(userID)
                    .collection(Constants.FirestoreDB.movies)
                    .document(String(movieID))
                
                // Fetch the document
                let snapshot = try await movieDocRef.getDocument()
                guard let data = snapshot.data(), snapshot.exists else {
                    fetchSingleMovieDelegate?.didNotFindMovieInWatchlist(movieID: movieID)
                    return
                }
                
                // Parse the movie data to MovieDetailsTDO
                guard let id = data[Constants.FirestoreDB.MovieData.id] as? Int,
                      let original_title = data[Constants.FirestoreDB.MovieData.originalTitle] as? String,
                      let overview = data[Constants.FirestoreDB.MovieData.overview] as? String,
                      let poster_path = data[Constants.FirestoreDB.MovieData.posterPath] as? String,
                      let release_date = data[Constants.FirestoreDB.MovieData.releaseDate] as? String,
                      let runtime = data[Constants.FirestoreDB.MovieData.runtime] as? Int,
                      let vote_average = data[Constants.FirestoreDB.MovieData.voteAverage] as? Double,
                      let genresArray = data[Constants.FirestoreDB.MovieData.genres] as? [[String: Any]] else {
                    print("FirestoreWatchListManager: The convert of the next data to MovieDetailsDTO failed: \(data)")
                    return
                }
                
                let genres: [Genre] = genresArray.compactMap { genreDict in
                    // Iterate on each genreDict - [String: Any] and try to convert it to Genre
                    guard let id = genreDict[Constants.FirestoreDB.MovieData.genreID] as? Int,
                          let name = genreDict[Constants.FirestoreDB.MovieData.genreName] as? String else {
                        print("FirestoreWatchListManager: The convert of the next genreDict to Genre failed: \(genreDict)")
                        return nil
                    }
                    
                    return Genre(id: id, name: name)
                }
                
                let movie = MovieDetailsDTO(id: id,
                                            original_title: original_title,
                                            poster_path: poster_path,
                                            overview: overview,
                                            vote_average: vote_average,
                                            release_date: release_date,
                                            runtime: runtime,
                                            genres: genres)
                
                // Notify delegate that the fetching executed successfully
                fetchSingleMovieDelegate?.didFetchSingleMovieFromWatchlist(movie)
                
            } catch {
                fetchSingleMovieDelegate?.didFailToFetchSingleMovieFromWatchlist(error: error)
            }
            
            // end Task
        }
        // end function
    }
}
