//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Student17 on 23/06/2025.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with movie: MovieListDTO) {
        movieTitle.text = movie.original_title
        let fullMoviePosterUrl = "\(Constants.TMDBURLs.TMDBImageBaseURL500)\(movie.poster_path)"
        ImageUtils.loadImage(from: fullMoviePosterUrl, into: moviePoster)
    }

}
