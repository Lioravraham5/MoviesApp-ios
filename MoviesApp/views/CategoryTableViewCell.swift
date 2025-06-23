//
//  CategoryTableViewCell.swift
//  MoviesApp
//
//  Created by Student17 on 23/06/2025.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        moviesCollectionView.register(UINib(nibName: Constants.MovieCollectionCell.cellNibName, bundle: nil),
                                      forCellWithReuseIdentifier: Constants.MovieCollectionCell.cellIdentifier) // register the custome cell to the the UICollectionView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
