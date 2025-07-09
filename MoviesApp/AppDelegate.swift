//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Student17 on 21/06/2025.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    /*orientationLock - variable that holds the screen orientation allowed in the app
     Default - enable all oriantation positions
     */
    var orientationLock: UIInterfaceOrientationMask = .all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.isEnabled = true // fix the open of the keyboard to not hide ui elements
        
        IQKeyboardManager.shared.resignOnTouchOutside = true // when press outside the keyboard it will dismiss
        
        FirebaseApp.configure() // Initialize Firebase services using the configuration from GoogleService-Info.plist
        
        let db = Firestore.firestore() // initialize an instance of Cloud firestore
        print("AppDelegate: Firestore Database instance - \(db)")
        
        return true
    }
    
    // Add this method to return orientationLock position
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

