//
//  Utilities.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 27/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static var urlBase = "http://www.omdbapi.com/"
    static var apiKey = "d2588d29"
    
    static func getParametersSearchMovie(movieTitle: String) -> [String:String]{
        return ["s":movieTitle, "apikey": apiKey]
    }
    
    static func getParametersSearchMovieDetail(movieID: String) -> [String:String]{
        return ["i":movieID, "apikey": apiKey]
    }
    
    static func checkImageUrl(imageURL: String) -> String {
        let urlString = imageURL != "" ? imageURL : "https://via.placeholder.com/150"
        return urlString
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
