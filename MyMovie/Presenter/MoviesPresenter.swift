//
//  MoviesPresenter.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 27/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import Foundation

protocol MoviesPresenterDelegate {
    
    func searchMovie(parameters: [String: String], body: [String: String])
    
}

class MoviesPresenter: MoviesPresenterDelegate {
    
    func searchMovie(parameters: [String: String], body: [String: String]) {
        
        model!.getMovies(parameters: parameters, body: [:], callBacks:{ (isSuccess, movies, error) in
            if isSuccess{
                self.movieController.successSearch(movies: movies)
            }else{
                print("error")
                //self.movieController.failed(error: error!)
            }
        })
    }
    
    var movieController: MovieControllerDelegate
    var model: MoviesModel?
    
    init(ui: MovieControllerDelegate){
        movieController = ui
        model = MoviesModel(presenter: self)
    }
    
}
