//
//  ThirdPartyLibrariesTableViewController.swift
//  MyMovies
//
//  Created by Antonio Fernández Martín on 18/09/2020.
//  Copyright © 2020 Antonio Fernández Martín. All rights reserved.
//

import UIKit

class ThirdPartyLibrariesTableViewController: UITableViewController {

    let nameLibraries = ["SDOSLoader", "SDOSEnvironment", "SDOSPluggableApplicationDelegate"]
    let libraries = ["https://github.com/SDOSLabs/SDOSLoader", "https://github.com/SDOSLabs/SDOSEnvironment", "https://github.com/SDOSLabs/SDOSPluggableApplicationDelegate"]
    //let libraries = ["SDOSLoader" : "https://github.com/SDOSLabs/SDOSLoader", "SDOSEnvironment" :"https://github.com/SDOSLabs/SDOSEnvironment", "SDOSPluggableApplicationDelegate" :"https://github.com/SDOSLabs/SDOSPluggableApplicationDelegate"]
    
    @IBOutlet var librariesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        librariesTableView.delegate = self
        librariesTableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameLibraries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "library", for: indexPath)
        
        cell.textLabel?.text = nameLibraries[indexPath.row]
        cell.textLabel?.textColor = .black
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: libraries[indexPath.row]) {
            UIApplication.shared.open(url)
        }
    }

}
