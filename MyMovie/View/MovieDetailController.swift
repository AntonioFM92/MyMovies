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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieDetailPresenter(ui: self)
        presenter?.getMovieDetail(parameters: Utilities.getParametersSearchMovieDetail(movieID: imdbID), body: [:])
        
    }
}

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
    }
    
    func successSearch(movieDetail: MovieDetailDto?) {
        if movieDetail != nil {
            presenter!.initMovieDetail(movieTitle: movieDetail!.title!, movieImage: movieDetail!.poster!, movieDate: movieDetail!.released!, movieDuration: movieDetail!.runtime!, movieGenre: movieDetail!.genre!, movieWebsite: movieDetail!.website!, moviePlot: movieDetail!.plot!)
        }
    }
    
}
