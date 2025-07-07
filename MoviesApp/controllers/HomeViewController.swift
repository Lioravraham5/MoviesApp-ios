//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    let firebaseAuthManager = FirebaseAuthManager()
    let movieAPIManager = MovieAPIManager()
    
    private var allCategories: [MovieCategory] = [
        .popular,
        .topRated,
        .upcoming,
        .genre(id: 28, name: "Action"),
        .genre(id: 35, name: "Comedy"),
        .genre(id: 12, name: "Adventure"),
        .genre(id: 18, name: "Drama"),
        .genre(id: 10751, name: "Family"),
        .genre(id: 27, name: "Horror"),
        .genre(id: 14, name: "Fantasy"),
        .genre(id: 10749, name: "Romance"),
        .genre(id: 878, name: "Science Fiction"),
        .genre(id: 99, name: "Documentary"),
        .genre(id: 36, name: "History")
        
    ]
    
    private var selectedMovieID: Int?

    private var moviesByCategory: [MovieCategory: [MovieListDTO]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firebaseAuthManager.logOutDelegate = self
        movieAPIManager.movieListFetchDelegate = self
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        
        categoriesTableView.register(UINib(nibName: Constants.CategoryTableCell.cellNibName, bundle: nil),
                                     forCellReuseIdentifier: Constants.CategoryTableCell.cellIdentifier) // register the custome cell to the the UITabelView
        
        fetchMoviesFromAllCategories()
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        firebaseAuthManager.logOutUser()
    }
    
    func fetchMoviesFromAllCategories() {
        for category in allCategories {
            switch category {
            case .popular:
                movieAPIManager.fetchPopularMovies()
            case .topRated:
                movieAPIManager.fetchTopRatedMovies()
            case .upcoming:
                movieAPIManager.fetchUpcomingMovies()
            case .genre(let id, _):
                movieAPIManager.fetchMoviesByGenre(genreID: id, category: category)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.HomeToMovieSegue {
            if let destinationVC = segue.destination as? MovieViewController,
               let movieID = selectedMovieID {
                destinationVC.movieIDOpt = movieID
            }
                    
        }
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

// MARK: - MovieListFetchDelegate
extension HomeViewController: MovieListFetchDelegate {
    func didReceiveMovies(_ movieAPIManager: MovieAPIManager, movies: [MovieListDTO], category: MovieCategory) {
        DispatchQueue.main.async {
            self.moviesByCategory[category] = movies
            self.categoriesTableView.reloadData() // updating categoriesTableView
        }
        
    }
    
    func didFailWithError(error: any Error, category: MovieCategory) {
        print("HomeViewController: Error loading \(category) movies: \(error.localizedDescription)")
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // one row per category
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CategoryTableCell.cellIdentifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell() // If it doesn't succeed to casting the cell to CategoryTableViewCell, it return an empty UITableViewCell
        }
        
        let category = allCategories[indexPath.section]
        let movies = moviesByCategory[category] ?? []
        
        cell.delegate = self // set HomeViewController delegate of CategoryTableViewCell
        
        cell.configure(with: movies)
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.CategoryTableCell.rowHeight)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allCategories[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        
        // Get the movie category
        let category = allCategories[section]
        
        // Icon for the category
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = .label // supports dark mode
        
        // Choose icon based on category
        switch category {
        case .popular:
            iconImageView.image = UIImage(systemName: "flame.fill")
        case .topRated:
            iconImageView.image = UIImage(systemName: "star.fill")
        case .upcoming:
            iconImageView.image = UIImage(systemName: "calendar.badge.plus")
        case .genre:
            iconImageView.image = UIImage(systemName: "film.fill")
        }
        
        // Title label
        let titleLabel = UILabel()
        titleLabel.text = category.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        headerView.addSubview(iconImageView)
        headerView.addSubview(titleLabel)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: headerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Constants.CategoryTableCell.headerSectionHeight)
    }
}

// MARK: - CategoryTableViewCellDelegate
extension HomeViewController: CategoryTableViewCellDelegate {
    func didSelectMovie(_ movie: MovieListDTO) {
        selectedMovieID = movie.id
        performSegue(withIdentifier: Constants.Segues.HomeToMovieSegue, sender: self)
    }
}
