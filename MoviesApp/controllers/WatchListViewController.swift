//
//  WatchListViewController.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

import UIKit

class WatchListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    private let firestoreWatchlistManager = FirestoreWatchListsManager()
    private var movies: [MovieDetailsDTO] = []
    private var selectedMovie: MovieDetailsDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        moviesTableView.register(
            UINib(nibName: Constants.MovieTableCell.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.MovieTableCell.cellIdentifier) // register the custome cell to the the UITabelView
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        firestoreWatchlistManager.readDelegate = self
        firestoreWatchlistManager.deleteDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LoadingIndicatorManager.show(on: self) // Show loading indicator
        firestoreWatchlistManager.fetchWatchList() // fetch Movies from firestore DB
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.WatchListToMovieSegue {
            if let destinationVC = segue.destination as? MovieViewController,
               let movie = selectedMovie {
                destinationVC.shouldFetchMovieFromAPI = false
                destinationVC.currrentMovieOpt = movie
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MovieTableCell.cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell() // If it doesn't succeed to casting the cell to MovieTableViewCell, it return an empty UITableViewCell
        }
        
        cell.delegate = self // set WatchListViewController delegate of MovieTableViewCell
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movies[indexPath.row]
        performSegue(withIdentifier: Constants.Segues.WatchListToMovieSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true) // Removes the highlight from the selected cell
        
    }
}

// MARK: - FirestoreWatchListReadDelegate
extension WatchListViewController: FirestoreWatchListReadDelegate {
    func didFetchWatchlistSuccessfully(_ movies: [MovieDetailsDTO]) {
        self.movies = movies
        DispatchQueue.main.async {
            LoadingIndicatorManager.hide()
            self.moviesTableView.reloadData() // Updating moviesTableView
        }
    }
    
    func didFailToFetchWatchlist(error: any Error) {
        print("Failed to fetch watchlist: \(error.localizedDescription)")
        DispatchQueue.main.async {
            LoadingIndicatorManager.hide()
            AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                             alertTitle: Constants.Alerts.watchlistFetchFailedAlertTitle,
                                                             alertMessage: Constants.Alerts.watchlistFetchFailedAlertMessage)
        }
        
    }
}

// MARK: - MovieTableViewCellDelegate
extension WatchListViewController: MovieTableViewCellDelegate {
    func didPressRemoveButton(in cell: MovieTableViewCell) {
        guard let indexPath = moviesTableView.indexPath(for: cell) else {
            print("WatchListViewController: Failed to find indexPath for the tapped cell. The cell might not be currently visible or attached to the tableView.")
            return
        }
        
        let movieToDelete = movies[indexPath.row]
        firestoreWatchlistManager.deleteMovieFromWatchlist(movieID: movieToDelete.id) // delete movie from firestore db
    }
}

// MARK: - FirestoreWatchListDeleteDelegate
extension WatchListViewController: FirestoreWatchListDeleteDelegate {
    func didDeleteMovieFromWatchlistSuccessfully(movieID: Int) {
        print("WatchListViewController: Successfully deleted movie with ID \(movieID) from watchlist.")
       
        // Search movie in movies and remove it from movies and remove its cell moviesTableView
        if let index = movies.firstIndex(where: { $0.id == movieID }) {
            movies.remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            DispatchQueue.main.async {
                self.moviesTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func didFailToDeleteMovieFromWatchlist(error: any Error) {
        print("WatchListViewController: Failed to delete moview from watchlist. Error: \(error.localizedDescription)")
        
        DispatchQueue.main.async {
            AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                             alertTitle: Constants.Alerts.watchlistDeleteFailedAlertTitle,
                                                             alertMessage: Constants.Alerts.watchlistDeleteFailedAlertMessage)
        }
    }
    
    
}
