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
    
}
