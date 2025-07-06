//
//  CategoryTableViewCell.swift
//  MoviesApp
//
//  Created by Student17 on 23/06/2025.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    private var movies: [MovieListDTO] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        moviesCollectionView.register(UINib(nibName: Constants.MovieCollectionCell.cellNibName, bundle: nil),
                                      forCellWithReuseIdentifier: Constants.MovieCollectionCell.cellIdentifier) // register the custome collection cell to the the UICollectionView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movies: [MovieListDTO]) {
        self.movies = movies
        self.moviesCollectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Here we will create a cell and return it to the CollectionView
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCollectionCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell() // If it doesn't succeed to casting the cell to MovieCollectionViewCell, it return an empty UITableViewCell
        }
        
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.MovieCollectionCell.cellWidth,
                      height: Constants.MovieCollectionCell.cellHeight)
    }
}
