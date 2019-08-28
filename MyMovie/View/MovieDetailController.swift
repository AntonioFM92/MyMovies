//
//  MovieDetailController.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 26/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import UIKit

protocol MovieDetailControllerDelegate {
    
    func initMovieDetail(movieTitle: String, movieImage: String, movieDate: String, movieDuration: String, movieGenre: String, movieWebsite: String, moviePlot: String)
    
    func successSearch(movieDetail: MovieDetailDto?)
    
}

class MovieDetailController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieDate: UILabel!
    @IBOutlet var movieDuration: UILabel!
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var movieWebSite: UITextView!
    @IBOutlet var moviePlot: UITextView!
    
    var movieDetailDto: MovieDetailDto?
    private var presenter: MovieDetailPresenterDelegate?
    var imdbID: String = ""
    
    var originalFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieDetailPresenter(ui: self)
        presenter?.getMovieDetail(parameters: Utilities.getParametersSearchMovieDetail(movieID: imdbID), body: [:])
        
        originalFrame = movieImage.frame
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        movieImage.addGestureRecognizer(tapGesture)
        
    }
    
    //Gesture to show image full screen
    @objc func tapped(_ sender: UITapGestureRecognizer? = nil) {
        
        let tapGestureToClose = UITapGestureRecognizer(target: self, action: #selector(self.tappedToClose(_:)))
        movieImage.addGestureRecognizer(tapGestureToClose)
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.bringSubviewToFront(movieImage)
        
        movieImage.frame = UIScreen.main.bounds
        movieImage.backgroundColor = UIColor.black
    }
    
    //Gesture to close image full screen
    @objc func tappedToClose(_ sender: UITapGestureRecognizer? = nil) {
        
        self.navigationController?.isNavigationBarHidden = false
        movieImage.frame = originalFrame!
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        movieImage.addGestureRecognizer(tapGesture)
    }
}

//MARK: - DelegateClass
extension MovieDetailController: MovieDetailControllerDelegate {
    
    func initMovieDetail(movieTitle: String, movieImage: String, movieDate: String, movieDuration: String, movieGenre: String, movieWebsite: String, moviePlot: String){
        self.movieTitle.text = movieTitle
        self.movieDate.text = movieDate
        self.movieDuration.text = movieDuration
        self.movieGenre.text = movieGenre
        
        self.movieWebSite.setAsLink(value: movieWebsite)
        self.movieWebSite.setTappable(value: movieWebsite)
        
        self.moviePlot.text = moviePlot
        
        self.movieImage.load(url: URL(string:Utilities.checkImageUrl(imageURL: movieImage))!)
        self.movieImage.setSaveGesture()
        //self.movieImage.setResizeGesture()
    }
    
    func successSearch(movieDetail: MovieDetailDto?) {
        if movieDetail != nil {
            presenter!.initMovieDetail(movieTitle: movieDetail!.title!, movieImage: movieDetail!.poster!, movieDate: movieDetail!.released!, movieDuration: movieDetail!.runtime!, movieGenre: movieDetail!.genre!, movieWebsite: movieDetail!.website!, moviePlot: movieDetail!.plot!)
        }
    }
    
}
