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
    
    //Load movieImage or image by default
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

extension UITextView {
    
    //ParentView of UITextView
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func setAsLink(value: String) {
        let attributedString = NSMutableAttributedString(string: value, attributes:[NSAttributedString.Key.link: URL(string: value)!])
        self.attributedText = attributedString
    }
    
    func setTappable(value: String) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer? = nil) {
        let urlToOpen = URL(string: self.text)!
        
        let activityViewController = UIActivityViewController(activityItems: [urlToOpen], applicationActivities: nil)
        self.parentViewController!.present(activityViewController, animated: true)
    }
    
}