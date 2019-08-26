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
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieYear: UILabel!
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
