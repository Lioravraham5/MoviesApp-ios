//
//  ViewController.swift
//  MoviesApp
//
//  Created by Student17 on 21/06/2025.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = .movieRed // change the back button color of the navigation bar to red
    
        logInButton.layer.cornerRadius = logInButton.frame.height / 2 // Make the button's corners rounded
        registerButton.layer.cornerRadius = registerButton.frame.height / 2 // Make the button's corners rounded
        
    }


}

