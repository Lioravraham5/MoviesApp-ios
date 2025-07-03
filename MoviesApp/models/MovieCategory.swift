//
//  MovieCategory.swift
//  MoviesApp
//
//  Created by Student17 on 03/07/2025.
//

import Foundation
enum MovieCategory: Int, CaseIterable {
    case popular
    case topRated
    case upcoming
    
    // Computed variable
    var title: String {
        switch self {
        case.popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
        
    }
}
