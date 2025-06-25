//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    let firebaseAuthManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firebaseAuthManager.logOutDelegate = self
        
        categoriesTableView.register(UINib(nibName: Constants.CategoryTableCell.cellNibName, bundle: nil),
                           forCellReuseIdentifier: Constants.CategoryTableCell.cellIdentifier) // register the custome cell to the the UITabelView
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: FirebaseAuthLogOutDelegate {
    func didLogOutSuccessfully() {
        navigationController?.popToRootViewController(animated: true) // pop the screens from the navigation stack untill the root of it - MainViewController
    }
    
    func didFailToLogOut(error: any Error) {
        print("HomeViewController: \(error)")
    }
    
    
}
