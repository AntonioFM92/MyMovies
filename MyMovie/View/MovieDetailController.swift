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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
