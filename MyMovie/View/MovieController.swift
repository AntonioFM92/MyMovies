//
//  MovieController.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 26/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import UIKit

protocol MovieControllerDelegate {
    
    func showLoadingView()
    func removeLoadingView()
    
    func successSearch(movies: MovieDto?)
    func failed(error: String)
    
}

class MovieController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var contentView: UIView!
    @IBOutlet var movieTableView: UITableView!
    
    var moviesDto: MovieDto?
    private var presenter: MoviesPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MoviesPresenter(ui: self)
        
        movieTableView.sectionHeaderHeight = 0.0
        movieTableView.sectionFooterHeight = 0.0
        movieTableView.tableFooterView = UIView(frame:CGRect.zero)
        
    }
    
}


//MARK: - DelegateClass
extension MovieController: MovieControllerDelegate {
    
    func showLoadingView(){
        showProgress(onView: self.contentView)
    }
    
    func removeLoadingView(){
        removeProgress()
    }
    
    func successSearch(movies: MovieDto?) {
        presenter?.removeLoadingView()
        if movies != nil {
            moviesDto = movies
            movieTableView.reloadData()
        }
    }
    
    func failed(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}

//MARK: - SearchBarDelegate
extension MovieController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if searchText.count > 3 {
            presenter?.showLoadingView()
            presenter?.searchMovie(parameters: Utilities.getParametersSearchMovie(movieTitle: self.searchBar.text!), body: [:])
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        
        presenter?.searchMovie(parameters: Utilities.getParametersSearchMovie(movieTitle: self.searchBar.text!), body: [:])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
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
