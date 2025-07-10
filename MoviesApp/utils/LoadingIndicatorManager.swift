//
//  LoadingIndicatorManager.swift
//  MoviesApp
//
//  Created by Student17 on 10/07/2025.
//

import Foundation
import UIKit

struct LoadingIndicatorManager {
    private static var indicator: UIActivityIndicatorView?
    private static var overlayView: UIView? // A dark background layer that appears behind the spinner
    
    /*Show a loading indicator on the given view controller.
      Parameters:
       - viewController: The view controller on which to display the indicator.
       - style: The style of the spinner (.large or .medium).
       - color: The color of the spinner.
       - overlayColor: The color of the background overlay.
       - shouldDimBackground: Whether to dim the background behind the spinner.
    */
    static func show(on viewController: UIViewController,
                     style: UIActivityIndicatorView.Style = .large,
                     color: UIColor = .gray,
                     overlayColor: UIColor = UIColor.black.withAlphaComponent(0.2),
                     shouldDimBackground: Bool = false) {
        
        DispatchQueue.main.async {
            // Prevent duplicate indicators and overlays on the viewController
            guard indicator == nil, overlayView == nil else {
                return
            }
            
            // Optional dimmed background
            if shouldDimBackground {
                let overlay = UIView(frame: viewController.view.bounds) // Create a transparent and dark background that covers the entire screen. bounds = the size of viewController.view
                overlay.backgroundColor = overlayColor
                viewController.view.addSubview(overlay)
                overlayView = overlay
            }
            
            // Create and configure activity indicator
            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.color = color
            activityIndicator.center = viewController.view.center
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            viewController.view.addSubview(activityIndicator)
            indicator = activityIndicator
        }
    }
    
    // Hide the currently displayed loading indicator
    static func hide() {
        DispatchQueue.main.async {
            indicator?.stopAnimating()
            indicator?.removeFromSuperview()
            overlayView?.removeFromSuperview()
            indicator = nil
            overlayView = nil
        }
    }
}
