//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Student17 on 24/06/2025.
//

import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func didPressRemoveButton(in cell: MovieTableViewCell)
}

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var movieTitleIcon: UIImageView!
    @IBOutlet weak var genresIcon: UIImageView!
    @IBOutlet weak var releaseYearIcon: UIImageView!
    @IBOutlet weak var movieRuntimeIcon: UIImageView!
    
    weak var delegate: MovieTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func removeButtonPressed(_ sender: UIButton) {
        delegate?.didPressRemoveButton(in: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with movie: MovieDetailsDTO){
        hideViews()
        
        movieTitle.text = movie.original_title
        
        let fullMoviePosterUrl = "\(Constants.TMDBURLs.TMDBImageBaseURL500)\(movie.poster_path)"
        ImageUtils.loadImage(from: fullMoviePosterUrl, into: moviePoster)
    
        genresLabel.text = movie.genresDisplayString
        releaseYearLabel.text = movie.releaseYearString
        movieRuntimeLabel.text = movie.runtimeString
        
        showViews()
        
    }
    
    private func hideViews() {
        moviePoster.isHidden = true
        movieTitle.isHidden = true
        genresLabel.isHidden = true
        releaseYearLabel.isHidden = true
        movieRuntimeLabel.isHidden = true
        movieTitleIcon.isHidden = true
        genresIcon.isHidden = true
        releaseYearIcon.isHidden = true
        movieRuntimeIcon.isHidden = true
        
    }
    
    private func showViews() {
        moviePoster.isHidden = false
        movieTitle.isHidden = false
        genresLabel.isHidden = false
        releaseYearLabel.isHidden = false
        movieRuntimeLabel.isHidden = false
        movieTitleIcon.isHidden = false
        genresIcon.isHidden = false
        releaseYearIcon.isHidden = false
        movieRuntimeIcon.isHidden = false
    }
    
}
