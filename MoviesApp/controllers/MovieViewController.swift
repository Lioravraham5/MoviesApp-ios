//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Student17 on 23/06/2025.
//

import UIKit
import Cosmos

class MovieViewController: UIViewController {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewContentLabel: UILabel!
    @IBOutlet weak var addToWatchListButton: UIButton!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var filmIcon: UIImageView!
    @IBOutlet weak var overviewHeadLineLabel: UILabel!
    
    var movieIDOpt: Int?
    
    private let movieAPIManager = MovieAPIManager()
    private let firestoreWatchlistManager = FirestoreWatchListsManager()
    private var currrentMovieOpt: MovieDetailsDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = .movieRed // change the back button color of the navigation bar to red
        
        hideViews()
        configureUI()
        
        firestoreWatchlistManager.writeDelegate = self
        
        if let movieID = movieIDOpt {
            print("MovieViewController: movieID - \(movieID)")
            movieAPIManager.movieFetchDelegate = self
            movieAPIManager.fetchMovieByID(movieID: movieID)
        } else{
            print("MovieViewController: movieID doesn't accepted, movieIDOpt - \(String(describing: movieIDOpt))")
        }
    }
    
    
    @IBAction func addToWatchListButtonPressed(_ sender: UIButton) {
        guard let currentMovie = currrentMovieOpt else {
            print("MovieViewController: No movie to save.")
            return
        }
        
        /*Since addMovieToWatchList(movie:) is marked as 'async', we must call it with 'await'.
         However, this IBAction method is not asynchronous, so we need to wrap the call in a Task block.
         */
        Task {
            await firestoreWatchlistManager.addMovieToWatchList(movie: currentMovie)
        }
        
        
    }
    
    func configureUI() {
        addToWatchListButton.layer.cornerRadius = addToWatchListButton.frame.height / 2 // Make the button's corners rounded
        cosmosView.settings.fillMode = .precise // Filling the start accurately
    }
    
    func hideViews() {
        moviePoster.isHidden = true
        movieTitle.isHidden = true
        releaseYearLabel.isHidden = true
        movieRuntimeLabel.isHidden = true
        genresLabel.isHidden = true
        overviewContentLabel.isHidden = true
        addToWatchListButton.isHidden = true
        cosmosView.isHidden = true
        calendarIcon.isHidden = true
        clockIcon.isHidden = true
        filmIcon.isHidden = true
        overviewHeadLineLabel.isHidden = true
    }
    
    func showViews() {
        moviePoster.isHidden = false
        movieTitle.isHidden = false
        releaseYearLabel.isHidden = false
        movieRuntimeLabel.isHidden = false
        genresLabel.isHidden = false
        overviewContentLabel.isHidden = false
        addToWatchListButton.isHidden = false
        cosmosView.isHidden = false
        calendarIcon.isHidden = false
        clockIcon.isHidden = false
        filmIcon.isHidden = false
        overviewHeadLineLabel.isHidden = false
    }
    
}

// MARK: - MovieFetchDelegate
extension MovieViewController: MovieFetchDelegate {
    func didReceiveMovie(_ movieAPIManager: MovieAPIManager, movie: MovieDetailsDTO) {
        DispatchQueue.main.async {
            self.currrentMovieOpt = movie
            self.updateUI(with: movie)
            self.showViews()
        }
    }
    
    func didFailWithError(error: any Error) {
        print("MovieViewController: Failed to fetch movie: \(error.localizedDescription)")
    }
    
    private func updateUI(with movie: MovieDetailsDTO) {
        
        // Set Image
        let fullMoviePosterUrl = "\(Constants.TMDBURLs.TMDBImageBaseURL500)\(movie.poster_path)"
        ImageUtils.loadImage(from: fullMoviePosterUrl, into: moviePoster)
        
        movieTitle.text = movie.original_title // Set Movie title
        releaseYearLabel.text = movie.releaseYearString // Set movie released year
        overviewContentLabel.text = movie.overview // Set movie overview
        movieRuntimeLabel.text =  movie.runtimeString // Set movie duration
        
        // Set stars rank
        cosmosView.rating = movie.vote_average
        cosmosView.text = String(format: "%.1f", movie.vote_average)
        
        genresLabel.text = movie.genresDisplayString // Set genres
        
    }
}

// MARK: - FirestoreWatchListWriteDelegate
extension MovieViewController: FirestoreWatchListWriteDelegate {
    func didAddMovieToWatchlistSuccessfully(_ movie: MovieDetailsDTO) {
        print("MovieViewController: The movie: ID - \(movie.id), Title - \(movie.original_title) added to watchlist successfully")
        DispatchQueue.main.async {
            AlertPresenterManager.showAutoDismissAlert(on: self,
                                                       alertTitle: Constants.Alerts.watchlistAddSuccessAlertTitle,
                                                       alertMessage: Constants.Alerts.watchlistAddSuccessAlertMessage(movie.original_title))
        }
    }
    
    func didFindMovieAlreadyInWatchlist(_ movie: MovieDetailsDTO) {
        print("MovieViewController: The movie: ID - \(movie.id), Title - \(movie.original_title) already in watchlist")
        DispatchQueue.main.async {
            AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                             alertTitle: Constants.Alerts.watchlistAlreadyExistsAlertTitle,
                                                             alertMessage: Constants.Alerts.watchlistAlreadyExistsAlertMessage(movie.original_title))
        }
        
        
    }
    
    func didFailToAddMovieToWatchlist(error: any Error) {
        print("MovieViewController: Failed to add the movie: \(error.localizedDescription)")
        DispatchQueue.main.async {
            AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                             alertTitle: Constants.Alerts.watchlistAddFailedAlertTitle,
                                                             alertMessage: Constants.Alerts.watchlistAddFailedAlertMessage)
        }
        
    }
    
    
}
