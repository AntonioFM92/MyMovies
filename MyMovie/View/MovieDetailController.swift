//
//  MovieDetailController.swift
//  MyMovie
//
//  Created by Antonio Fernández Martín on 26/08/2019.
//  Copyright © 2019 Antonio Fernández Martín. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieImage: UIImageView!
    
    @IBOutlet var movieDate: UILabel!
    @IBOutlet var movieDuration: UILabel!
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var movieWebSite: UILabel!
    @IBOutlet var moviePlot: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
