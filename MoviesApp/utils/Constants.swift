//
//  Constants.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

struct Constants {
    struct Segues {
        static let mainToLoginSegue = "MainToLogin"
        static let mainToRegisterSegue = "MainToRegister"
        static let RegisterToMainTabBarSegue = "RegisterToMainTabBar"
        static let LogInToMainTabBar = "LogInToMainTabBar"
        
        
    }
    
    struct CategoryTableCell{
        static let cellIdentifier = "CategoryTableViewCell"
        static let cellNibName = "CategoryTableViewCell"
    }
    
    struct MovieCollectionCell{
        static let cellIdentifier = "MovieCollectionViewCell"
        static let cellNibName = "MovieCollectionViewCell"
    }
    
 
}
