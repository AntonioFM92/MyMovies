//
//  MovieDetailPresenter.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 27/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterDelegate {
    
    func initMovieDetail(movieTitle: String, movieImage: String, movieDate: String, movieDuration: String, movieGenre: String, movieWebsite: String, moviePlot: String)
    
    func getMovieDetail(parameters: [String: String], body: [String: String])
}

class MovieDetailPresenter: MovieDetailPresenterDelegate {
    
    func getMovieDetail(parameters: [String: String], body: [String: String]) {
        
        model!.getMovieDetail(parameters: parameters, body: [:], callBacks:{ (isSuccess, movieDetail, error) in
            if isSuccess{
                self.movieDetailController.successSearch(movieDetail: movieDetail)
            }else{
                print("error")
                //self.movieController.failed(error: error!)
            }
        })
    }
    
    
    var movieDetailController: MovieDetailControllerDelegate
    var model: MovieDetailModel?
    
    init(ui: MovieDetailControllerDelegate){
        movieDetailController = ui
        model = MovieDetailModel(presenter: self)
    }
    
    func initMovieDetail(movieTitle: String, movieImage: String, movieDate: String, movieDuration: String, movieGenre: String, movieWebsite: String, moviePlot: String){
        movieDetailController.initMovieDetail(movieTitle: movieTitle, movieImage: movieImage, movieDate: movieDate, movieDuration: movieDuration, movieGenre: movieGenre, movieWebsite: movieWebsite, moviePlot: moviePlot)
    }
    
}
