//
//  MovieCategory.swift
//  MoviesApp
//
//  Created by Student17 on 03/07/2025.
//

import Foundation
//enum MovieCategory: Int, CaseIterable {
//    case popular
//    case topRated
//    case upcoming
//
//    // Computed variable
//    var title: String {
//        switch self {
//        case .popular: return "Popular"
//        case .topRated: return "Top Rated"
//        case .upcoming: return "Upcoming"
//        }
//        
//    }
//}

enum MovieCategory: Hashable {
    case popular
    case topRated
    case upcoming
    case genre(id: Int, name: String)

    // Computed variable
    var title: String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        case .genre(_ , let name): return name
        }
    }
    
    var id: Int {
        switch self {
        case .popular: return -1
        case .topRated: return -2
        case .upcoming: return -3
        case .genre(let id , _): return id
        }
        
    }
}
