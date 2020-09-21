//
//  FavouritesController.swift
//  MyMovies
//
//  Created by Antonio Fernández Martín on 09/09/2020.
//  Copyright © 2020 Antonio Fernández Martín. All rights reserved.
//

import UIKit
import SDOSLoader
import CoreData

protocol FavouritesControllerDelegate {
    
    func showLoadingView()
    func removeLoadingView()
    
    func success(movies: [MovieEntity]?)
    func failed(error: String)
}

class FavouritesController: UIViewController {
    
    var moviesDto: MovieDto?
    var movieDetailDto: MovieDetailDto?
    private var presenter: FavouritesPresenterDelegate?
    var favouritesMovies: [MovieEntity]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FavouritesPresenter(ui: self)
        
        tableView.sectionHeaderHeight = 0.0
        tableView.sectionFooterHeight = 0.0
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.getFavouritesMovies()
    }
    
}


//MARK: - DelegateClass
extension FavouritesController: FavouritesControllerDelegate {
    
    func showLoadingView(){
        showProgress(onView: self.view)
    }
    
    func removeLoadingView(){
        removeProgress()
    }
    
    func success(movies: [MovieEntity]?) {
        presenter?.removeLoadingView()
        guard let movies = movies else {
            return
        }
        favouritesMovies = movies
        
        tableView.reloadData()
    }
    
    func failed(error: String) {
        let alert = UIAlertController(title: error, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}


//MARK: - TableViewDelegate
extension FavouritesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favouritesMovies = favouritesMovies else {
            return 0
        }
        return favouritesMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "movieCell")
        }
        
        guard let favouritesMovies = favouritesMovies else {
            return UITableViewCell()
        }
        
        movieCell.setCellValues(movieImage: favouritesMovies[indexPath.row].poster, movieTitle: favouritesMovies[indexPath.row].title, movieYear: favouritesMovies[indexPath.row].year)
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "movieDetailController") as? MovieDetailController else {
            return
        }
        guard let favouritesMovies = favouritesMovies else {
            return
        }
        movieDetailViewController.imdbID = favouritesMovies[indexPath.row].imdbID
        self.navigationController?.pushViewController(movieDetailViewController, animated: false)
    }
    
}
