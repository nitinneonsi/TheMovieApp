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
    let movies = [Movies]()
    
    var pageNo = 1

    @IBOutlet weak var tableViewMovies: UITableView!
    
    // Mark: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark: Calling API
        jsonHelper.getAPIData(page: pageNo, completion:{[weak self] response in
            
            self?.results = response
            DispatchQueue.main.async {
                self?.tableViewMovies.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // Mark: TableView Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewMovies.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        
        let result = results[indexPath.row]
        cell.configCell(movie: result)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == results.count-1
        {
            if results.count < jsonHelper.totalRecords
            {
                pageNo = pageNo+1
                loadMoreRecords(page: pageNo)
            }
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // This is the last cell
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.color = UIColor.purple
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableViewMovies.bounds.width, height: CGFloat(44))
            
            self.tableViewMovies.tableFooterView = spinner
            self.tableViewMovies.tableFooterView?.isHidden = false
        }
    }
    
    // Mark: Loding more records
    func loadMoreRecords(page: Int) {
        jsonHelper.getAPIData(page: page, completion:{[weak self] response in
            
            self?.results.append(contentsOf: response)
            DispatchQueue.main.async {
                self?.tableViewMovies.reloadData()
            }
        })
    }
}
