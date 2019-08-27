//
//  MovieController.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 26/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import UIKit

protocol MovieControllerDelegate {
    
    func successSearch(movies: MovieDto?)
    //func failed( error: ErrorDto)
    
}

class MovieController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var movieTableView: UITableView!
    
    var moviesDto: MovieDto?
    private var presenter: MoviesPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MoviesPresenter(ui: self)
        
    }
    
}


//MARK: - DelegateClass
extension MovieController: MovieControllerDelegate {
    
    func successSearch(movies: MovieDto?) {
        if movies != nil {
            moviesDto = movies
            movieTableView.reloadData()
        }
    }
    
}

//MARK: - SearchBarDelegate
extension MovieController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            presenter?.searchMovie(parameters: Utilities.getParametersSearchMovie(movieTitle: self.searchBar.text!), body: [:])
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        presenter?.searchMovie(parameters: Utilities.getParametersSearchMovie(movieTitle: self.searchBar.text!), body: [:])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}


//MARK: - TableViewDelegate
extension MovieController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesDto?.search != nil {
            return (moviesDto?.search?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell: MovieCell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        
        movieCell.setCellValues(movieImage: (moviesDto?.search![indexPath.row].poster)!, movieTitle: (moviesDto?.search![indexPath.row].title)!, movieYear: (moviesDto?.search![indexPath.row].year)!)
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "movieDetailController") as! MovieDetailController
        movieDetailViewController.imdbID = (moviesDto?.search![indexPath.row].imdbID)!
        self.navigationController?.pushViewController(movieDetailViewController, animated: false)
    }
    
}
