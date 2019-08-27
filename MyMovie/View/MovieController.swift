//
//  MovieController.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 26/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import UIKit

class MovieController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//MARK: - TableViewDelegate
extension MovieController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell: MovieCell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        
        movieCell.setCellValues(movieImage: "", movieTitle: "", movieYear: "")
        
        return movieCell
    }
    
    
}
