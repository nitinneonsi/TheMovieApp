//
//  ViewController.swift
//  TheMovieApp
//
//  Created by Nitz on 24/06/20.
//  Copyright © 2020 TM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let jsonHelper = ServiceHelper()
    var results = [Results]()
    
    var pageNo = 1

    @IBOutlet weak var tableViewMovies: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonHelper.getAPIData(page: pageNo, completion:{[weak self] response in
            
            self?.results = response
            DispatchQueue.main.async {
                self?.tableViewMovies.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // Mark: TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewMovies.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        
        let result = results[indexPath.row]
        cell.configCell(movie: result)
        
        return cell
    }
}
