//
//  LogInViewController.swift
//  MoviesApp
//
//  Created by Student17 on 22/06/2025.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    let firebaseAuthManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firebaseAuthManager.logInDelegate = self
        
        setupPasswordToggle() // create show password button in passwordTextField
        configureUI()
        
    }
    
    func configureUI() {
        
        logInButton.layer.cornerRadius = logInButton.frame.height / 2 // Make the button's corners rounded
        
        // Rounded emailTextField
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.clipsToBounds = true
        
        // Set emailTextField placeholder
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter your email..",
            attributes: [.foregroundColor: UIColor(named: "textfield_placeholder_color")!]
        )
        
        // Rounded passwordTextField
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.clipsToBounds = true
        
        // Set passwordTextField placeholder
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter your password...",
            attributes: [.foregroundColor: UIColor(named: "textfield_placeholder_color")!]
        )
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
    
    
    @IBAction func LogInButtonPressed(_ sender: UIButton) {
        logInButton.isEnabled = false
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        print("LogInViewController: Email entered - \(email), Password entered - \(password)")
        firebaseAuthManager.logInUser(email: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

// MARK: - FirebaseAuthLogInDelegate
extension LogInViewController: FirebaseAuthLogInDelegate {
    func didLogInSuccessfully() {
        self.performSegue(withIdentifier: Constants.Segues.LogInToMainTabBarSegue, sender: self)
        
    }
    
    func didFailToLogIn(error: any Error) {
        print("LogInViewController: \(error.localizedDescription)")
        
        if let errCode = AuthErrorCode(rawValue: (error as NSError).code) {
            switch errCode {
            case .invalidEmail, .userNotFound, .missingEmail:
                AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                                 alertTitle: Constants.Alerts.logInInvalidEmailAlertTitle,
                                                                 alertMessage: Constants.Alerts.logInInvalidEmailAlertMessage)
                
            case .wrongPassword:
                AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                                 alertTitle: Constants.Alerts.logInInvalidPasswordAlertTitle,
                                                                 alertMessage: Constants.Alerts.logInInvalidPasswordAlertMessage)
            default:
                AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                                 alertTitle: Constants.Alerts.generalLoginAlertTitle,
                                                                 alertMessage: Constants.Alerts.generalLoginAlertMessage)
            }
        }
        logInButton.isEnabled = true
    }
    
    
}
