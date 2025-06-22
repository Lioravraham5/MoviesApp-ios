//
//  LogInViewController.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

import UIKit

class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupPasswordToggle() // create shoe password button in passwordTextField

        
        logInButton.layer.cornerRadius = logInButton.frame.height / 2 // Make the button's corners rounded
        
        // Rounded emailTextField
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.clipsToBounds = true
        
        // Rounded passwordTextField
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.clipsToBounds = true
        
    }
    

    func setupPasswordToggle() {
        let button = UIButton(type: .custom) // create a button without default design
        button.setImage(UIImage(systemName: "eye"), for: .normal) // set eye icon in normal state
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected) // set eye.slash icon when the button selected
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside) //call togglePasswordVisibility() when button pressed

        passwordTextField.rightView = button
        passwordTextField.rightViewMode = .always // Make the button always visible in the textField
    }

    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle() // change the selected state of the button
        passwordTextField.isSecureTextEntry.toggle() // Toggle the text visibility (secure vs plain text)
    }

}
