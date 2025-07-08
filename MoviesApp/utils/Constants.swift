//
//  Constants.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

struct Constants {
    
    // MARK: - TMDBURLs
    struct TMDBURLs {
        static let TMDBImageBaseURL185 = "https://image.tmdb.org/t/p/w185"
        static let TMDBImageBaseURL500 = "https://image.tmdb.org/t/p/w500"
    }
    
    // MARK: - Segues
    struct Segues {
        static let mainToLoginSegue = "MainToLogin"
        static let mainToRegisterSegue = "MainToRegister"
        static let RegisterToMainTabBarSegue = "RegisterToMainTabBar"
        static let LogInToMainTabBarSegue = "LogInToMainTabBar"
        static let HomeToMovieSegue = "HomeToMovie"
        static let WatchListToMovieSegue = "WatchListToMovie"
    }
    
    // MARK: - CategoryTableCell
    struct CategoryTableCell{
        static let cellIdentifier = "CategoryTableViewCell"
        static let cellNibName = "CategoryTableViewCell"
        static let rowHeight = 260
        static let headerSectionHeight = 50
    }
    
    // MARK: - MovieTableCell
    struct MovieTableCell {
        static let cellIdentifier = "MovieTableViewCell"
        static let cellNibName = "MovieTableViewCell"
    }
    
    // MARK: - MovieCollectionCell
    struct MovieCollectionCell{
        static let cellIdentifier = "MovieCollectionViewCell"
        static let cellNibName = "MovieCollectionViewCell"
        static let cellWidth = 200
        static let cellHeight = 253
    }
    
    // MARK: - Alerts
    struct Alerts {
        
        // RegisterViewController
        static let invalidEmailAlertTitle = "Invalid Email"
        static let invalidEmailAlertMessage = "Email must be in a valid format (e.g., user@example.com)."
        
        static let invalidPasswordAlertTitle = "Invalid Password"
        static let invalidPasswordAlertMessage = """
        Please make sure your password meet the following requirements:
        
        • At least one lowercase letter (a–z)
        • At least one number (0–9)
        • Minimum of 6 characters
        """
        
        static let emailAlreadyInUseAlertTitle = "Email Already Registered"
        static let emailAlreadyInUseAlertMessage = "The email address you entered is already associated with an existing account. Please try to use a different email address."
        
        static let generalRegistrationAlertTitle = "Registration Failed"
        static let generalRegistrationAlertMessage = "Something went wrong during the registration process. Please try again later"
        
        
        // LoginViewController
        static let logInInvalidEmailAlertTitle = "Account Not Found"
        static let logInInvalidEmailAlertMessage = "The email address you entered doesn't match any account. Please check for typos or register for a new account."
            
        static let logInInvalidPasswordAlertTitle = "Incorrect Password"
        static let logInInvalidPasswordAlertMessage = "The password you entered is incorrect. Please try again."
            
        static let generalLoginAlertTitle = "Login Failed"
        static let generalLoginAlertMessage = "We couldn't log you in. Please check your email and password, and ensure you have an internet connection."
        
        // MovieViewController - watchlist alerts
        static let watchlistAddSuccessAlertTitle = "Movie added"
        static func watchlistAddSuccessAlertMessage(_ movieTitle: String) -> String {
            return "The movie - \"\(movieTitle)\" was successfully added to your watchlist."
        }
        
        static let watchlistAlreadyExistsAlertTitle = "Movie is already added"
        static func watchlistAlreadyExistsAlertMessage(_ movieTitle: String) -> String {
            return "The movie - \"\(movieTitle)\" is already in your watchlist."
        }
        
        static let watchlistAddFailedAlertTitle = "Add Failed"
        static let watchlistAddFailedAlertMessage = "We couldn't add this movie to your watchlist. Please try again later."
        
    }
    
    // MARK: - FirestoreDB
    struct FirestoreDB {
        static let watchlists = "watchlists" // Main collection for users watchlists"
        static let movies = "movies" // Sub collection for movies inside of 'userID' inside of "watchlists"
        
        struct MovieData {
            static let id = "id"
            static let originalTitle = "original_title"
            static let overview = "overview"
            static let posterPath = "poster_path"
            static let releaseDate = "release_date"
            static let runtime = "runtime"
            static let voteAverage = "vote_average"
            static let genres = "genres"
            static let genreID = "id"
            static let genreName = "name"
            static let addedAt = "added_at"
        }
    }
    
 
}
