//
//  RegisterViewController.swift
//  MoviesApp
//
//  Created by Student17 on 21/06/2025.
//

import UIKit
import FirebaseAuth
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let firebaseAuthManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firebaseAuthManager.registerDelegate = self
        
        setupPasswordToggle() // create show password button in passwordTextField
        configureUI()
        
    }
    
    func configureUI() {
        registerButton.layer.cornerRadius = registerButton.frame.height / 2 // Make the button's corners rounded
        
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
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        guard firebaseAuthManager.isValidPassword(password) else {
            print("RegisterViewController: Password is not valid: \(password)")
            AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                             alertTitle: Constants.Alerts.invalidPasswordAlertTitle, alertMessage: Constants.Alerts.invalidPasswordAlertMessage)
            return
        }
        print("RegisterViewController: Password is valid: \(password)")
        firebaseAuthManager.registerUser(email: email, password: password)
    }
}

// MARK: - FirebaseAuthRegisterDelegate
extension RegisterViewController: FirebaseAuthRegisterDelegate {
    
    func didRegisterSuccessfully() {
        self.performSegue(withIdentifier: Constants.Segues.RegisterToMainTabBarSegue, sender: self)
    }
    
    func didFailToRegister(error: any Error) {
        print("RegisterViewController: \(error.localizedDescription)")
        
        if let errCode = AuthErrorCode(rawValue: (error as NSError).code) {
            switch errCode {
            case .invalidEmail, .missingEmail:
                AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                                 alertTitle: Constants.Alerts.invalidEmailAlertTitle, alertMessage: Constants.Alerts.invalidEmailAlertMessage)
            case .emailAlreadyInUse:
                AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                                 alertTitle: Constants.Alerts.emailAlreadyInUseAlertTitle, alertMessage: Constants.Alerts.emailAlreadyInUseAlertMessage)
            
            default:
                AlertPresenterManager.ShowAlertWithConfirmButton(on: self,
                                                                 alertTitle: Constants.Alerts.generalRegistrationAlertTitle,
                                                                 alertMessage: Constants.Alerts.generalRegistrationAlertMessage)
            }
        }
    }
}
