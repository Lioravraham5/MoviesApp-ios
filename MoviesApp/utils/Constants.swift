//
//  Constants.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

struct Constants {
    
    struct TMDBURLs {
        static let TMDBImageBaseURL185 = "https://image.tmdb.org/t/p/w185"
        static let TMDBImageBaseURL500 = "https://image.tmdb.org/t/p/w500"
    }
    
    struct Segues {
        static let mainToLoginSegue = "MainToLogin"
        static let mainToRegisterSegue = "MainToRegister"
        static let RegisterToMainTabBarSegue = "RegisterToMainTabBar"
        static let LogInToMainTabBarSegue = "LogInToMainTabBar"
        static let HomeToMovieSegue = "HomeToMovie"
        static let WatchListToMovieSegue = "WatchListToMovie"
    }
    
    struct CategoryTableCell{
        static let cellIdentifier = "CategoryTableViewCell"
        static let cellNibName = "CategoryTableViewCell"
        static let rowHeight = 260
        static let headerSectionHeight = 50
    }
    
    struct MovieTableCell {
        static let cellIdentifier = "MovieTableViewCell"
        static let cellNibName = "MovieTableViewCell"
    }
    
    struct MovieCollectionCell{
        static let cellIdentifier = "MovieCollectionViewCell"
        static let cellNibName = "MovieCollectionViewCell"
        static let cellWidth = 200
        static let cellHeight = 253
    }
    
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
        
    }
    
 
}
