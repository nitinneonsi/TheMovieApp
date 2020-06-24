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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonHelper.getAPIData(page: 1, completion:{response in
            print("Movies Data in VC : \(response)")
        })
    }
}

