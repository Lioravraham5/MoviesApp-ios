//
//  AlertPresenterManager.swift
//  MoviesApp
//
//  Created by Student17 on 25/06/2025.
//

import UIKit
import Foundation

class AlertPresenterManager {
    // MARK: - Show simple alert with confirm button
    
    static func ShowAlertWithConfirmButton(on viewController: UIViewController,
                                           alertTitle: String,
                                           alertMessage: String,
                                           confirmButtonTitle: String = "OK",
                                           completion: (() -> Void)? = nil) {
        
        // Define alert
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        
        
        // Define confirm button
        let confirmAction = UIAlertAction(title: confirmButtonTitle,
                                          style: .default) { _ in
            completion?()
        }
        
        // Add action to alert
        alert.addAction(confirmAction)
        
        // Show alert
        viewController.present(alert, animated: true)
    }
    
    // MARK: - Show simple alert with confirm and cancel button
    static func showAlertWithConfirmationAndCancelButtons(on viewController: UIViewController,
                                                          alerTitle: String,
                                                          alertMessage: String,
                                                          confirmButtonTitle: String = "Confirm",
                                                          cancelButtonTitle: String = "Cancel",
                                                          confirmStyle: UIAlertAction.Style = .default,
                                                          confirmHandler: @escaping () -> Void,
                                                          cancelHandler: (() -> Void)? = nil) {
        // Define alert
        let alert = UIAlertController(title: alerTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        
        // Define confirm button
        let confirmAction = UIAlertAction(title: confirmButtonTitle, style: confirmStyle) { _ in
            confirmHandler()
        }
        
        // Define cancel button
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            cancelHandler?()
        }
        // Add actions yo alert
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        // Show alert
        viewController.present(alert, animated: true)
    }
    
    
    // MARK: - Show auto-dismiss alerr (no buttons)
    static func showAutoDismissAlert(on viewController: UIViewController,
                                      alertTitle: String,
                                      alertMessage: String,
                                      duration: TimeInterval = 3.0) {
        
        // Define alert
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        
        // Show alert
        viewController.present(alert, animated: true)
        
        // Dismiss alert after "duration"of seconds - Default 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
