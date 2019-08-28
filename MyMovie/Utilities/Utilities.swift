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
    
    //ParentView of UIImageView
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
    
    func setSaveGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        self.addGestureRecognizer(longGesture)
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer? = nil) {
        
        let alert = UIAlertController(title: "¿Desea guardar la imagen?", message: "Se guardará automáticamente en el carrete.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: {
            action in UIImageWriteToSavedPhotosAlbum(self.image!, nil, nil, nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.parentViewController!.present(alert, animated: true)
        
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
        let attributedString = NSMutableAttributedString(string: value, attributes:[NSAttributedString.Key.link: URL(string: value) ?? ""])
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


var loadingView : UIView?

extension UIViewController {
    
    func showProgress(onView: UIView) {
        if loadingView == nil {
            let loadingProgressView = UIView.init(frame: onView.bounds)
            loadingProgressView.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
            
            let indicatorView = UIActivityIndicatorView.init(style: .whiteLarge)
            indicatorView.startAnimating()
            indicatorView.center = loadingProgressView.center
            
            DispatchQueue.main.async {
                loadingProgressView.addSubview(indicatorView)
                onView.addSubview(loadingProgressView)
            }
            
            loadingView = loadingProgressView
        }
    }
    
    func removeProgress() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }
    
}

