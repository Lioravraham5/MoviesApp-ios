//
//  FirebaseAuthManager.swift
//  MoviesApp
//
//  Created by Student17 on 24/06/2025.
//

import Foundation
import FirebaseAuth

// MARK: FirebaseAuthManager protocols
protocol FirebaseAuthRegisterDelegate: AnyObject {
    func didRegisterSuccessfully()
    func didFailToRegister(error: Error)
}

protocol FirebaseAuthLogInDelegate: AnyObject {
    func didLogInSuccessfully()
    func didFailToLogIn(error: Error)
}

protocol FirebaseAuthLogOutDelegate: AnyObject {
    func didLogOutSuccessfully()
    func didFailToLogOut(error: Error)
}

// MARK: FirebaseAuthManager class
class FirebaseAuthManager {
    
    weak var registerDelegate: FirebaseAuthRegisterDelegate?
    weak var logInDelegate: FirebaseAuthLogInDelegate?
    weak var logOutDelegate: FirebaseAuthLogOutDelegate?
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, errorOpt in
            if let error =  errorOpt {
                self.registerDelegate?.didFailToRegister(error: error)
            } else {
                self.registerDelegate?.didRegisterSuccessfully()
            }
        }
    }
    
    func logInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, errorOpt in
            if let error =  errorOpt {
                self.logInDelegate?.didFailToLogIn(error: error)
            } else {
                self.logInDelegate?.didLogInSuccessfully()
            }
        }
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            self.logOutDelegate?.didLogOutSuccessfully()
        } catch {
            self.logOutDelegate?.didFailToLogOut(error: error) // The error parameter throws from: try Auth.auth().signOut()
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    /*My password validation:
     - At least one lowercase letter (a–z)
     - At least one number (0–9)
     - Minimum of 6 characters
    */
    func isValidPassword(_ password: String) -> Bool {
        // Check minimum length
        guard password.count >= 6 else {
            return false
        }
        
        // Check for at least one letter a-z (lowercase or uppercase)
        let letterRegex = ".*[a-zA-Z]+.*"
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", letterRegex)
        
        // Check for at least one digit 0-9
        let digitRegex = ".*[0-9]+.*"
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        
        return letterPredicate.evaluate(with: password) && digitPredicate.evaluate(with: password)
    }
    
}
