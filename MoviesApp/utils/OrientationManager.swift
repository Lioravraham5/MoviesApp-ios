//
//  OrientationManager.swift
//  MoviesApp
//
//  Created by Student17 on 09/07/2025.
//

import Foundation
import UIKit

struct OrientationManager {
    
    /*Locks the app's interface orientation to a specific orientation mask (e.g. portrait, landscape).
      Parameter orientation: The orientation mask to lock (e.g. `.portrait`, `.landscape`, `.all`, etc.)
     */
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        // Access the shared AppDelegate and set its orientationLock property
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /*Locks the orientation and immediately rotates the device to the specified orientation.
      Parameters:
      - orientation: The orientation mask to lock the interface to.
      - rotateOrientation: The specific orientation to rotate the device to (e.g. `.landscapeRight`)
    */
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation, for viewController: UIViewController) {
        // First lock the allowed orientation
        self.lockOrientation(orientation)
        
        // Then rotate the device immediately to the desired orientation
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        
        // Ask the system to attempt applying the new orientation
        viewController.setNeedsUpdateOfSupportedInterfaceOrientations()
    }
}
