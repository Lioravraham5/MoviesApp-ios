//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

import UIKit

class HomeViewController: UIViewController, MovieListFetchDelegate {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    let firebaseAuthManager = FirebaseAuthManager()
    let movieAPIManager = MovieAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firebaseAuthManager.logOutDelegate = self
        movieAPIManager.movieListFetchDelegate = self
        
        categoriesTableView.register(UINib(nibName: Constants.CategoryTableCell.cellNibName, bundle: nil),
                                     forCellReuseIdentifier: Constants.CategoryTableCell.cellIdentifier) // register the custome cell to the the UITabelView
        
        // ✅ Choose any of these:
        // movieAPIManager.fetchPopularMovies()
        //movieAPIManager.fetchTopRatedMovies()
        //movieAPIManager.fetchMoviesByGenre(genreID: 28)
        //movieAPIManager.fetchUpcomingMovies()
        
        movieAPIManager.fetchMovieByID(movieID: 1100988)
        
        
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        firebaseAuthManager.logOutUser()
    }
    
    func didReceiveMovies(_ movieAPIManager: MovieAPIManager, movies: [MovieListDTO]) {
        print("✅ Received \(movies.count) movies:")
        for movie in movies {
            //print("\n\(movie)")
            print("- \(movie.original_title)")
        }
    }
    
    func didFailWithError(error: any Error) {
        print("❌ Error fetching movies:", error.localizedDescription)
    }
    
}
// MARK: - FirebaseAuthLogOutDelegate
extension HomeViewController: FirebaseAuthLogOutDelegate {
    func didLogOutSuccessfully() {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            // window - is the main window of my application
            
            // Check if the rootViewController of the main window is an UINavigationController
            if let navController = window.rootViewController as? UINavigationController {
                navController.popToRootViewController(animated: true) // pop the screens from the navigation stack untill the root of it - MainViewController
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func didFailToLogOut(error: any Error) {
        print("HomeViewController: \(error)")
    }
    
    
}
