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
    
    let movieAPIManager = MovieAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = .movieRed // change the back button color of the navigation bar to red
        
        hideViews()
        configureUI()
        
        if let movieID = movieIDOpt {
            print("MovieViewController: movieID - \(movieID)")
            movieAPIManager.movieFetchDelegate = self
            movieAPIManager.fetchMovieByID(movieID: movieID)
        } else{
            print("MovieViewController: movieID doesn't accepted, movieIDOpt - \(String(describing: movieIDOpt))")
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
        
        // Set movie released year
        if let year = extractYear(from: movie.release_date) {
            releaseYearLabel.text = year
        } else {
            releaseYearLabel.text = "To Be Determined"
        }
        
        overviewContentLabel.text = movie.overview // Set movie overview
        
        movieRuntimeLabel.text = "\(movie.runtime / 60) h \(movie.runtime % 60) min" // Set movie duration
       
        // Set stars rank
        cosmosView.rating = movie.vote_average
        cosmosView.text = String(format: "%.1f", movie.vote_average)
        
        genresLabel.text = movie.genresDisplayString // Set genres
        
    }
    
    private func extractYear(from releaseDate: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        if let date = formatter.date(from: releaseDate) {
            let year = Calendar.current.component(.year, from: date)
            return String(year)
        }
        
        return nil // In case of invalid date
    }
    
}
