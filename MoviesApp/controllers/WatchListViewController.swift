//
//  WatchListViewController.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

import UIKit

class WatchListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        moviesTableView.register(
            UINib(nibName: Constants.MovieTableCell.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.MovieTableCell.cellIdentifier) // register the custome cell to the the UITabelView
    }
}
