//
//  ImageUtils.swift
//  MoviesApp
//
//  Created by Student17 on 03/07/2025.
//
import Foundation
import UIKit

struct ImageUtils {
    static func loadImage(from urlString: String, into imageView: UIImageView) {
        
        // Attempt to create a valid URL from the given string
        guard let url = URL(string: urlString) else {
            print("ImageUtils: Invalid URL: \(urlString)")
            return
        }

        // Perform the image request on a background thread
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Handle network or request error
            if let error = error {
                print("ImageUtils: Error loading image: \(error)")
                return
            }

            // Ensure valid data and attempt to create a UIImage from it
            guard let data = data, let image = UIImage(data: data) else {
                print("ImageUtils: Invalid image data")
                return
            }

            // Update the UIImageView on the main thread (UI updates must run on main thread)
            DispatchQueue.main.async {
                imageView.image = image
            }

        }.resume() // Start the network request
    }
}
