//
//  ServiceHelper.swift
//  TheMovieApp
//
//  Created by Nitz on 24/06/20.
//  Copyright © 2020 TM. All rights reserved.
//

import Foundation

class ServiceHelper {
    
    var results = [Results]()
    
    // Mark: Calling API
    func getAPIData(page: Int, completion: @escaping ([Results]) -> Void) {
        
        let urlStr = URL(string: NetworkingConstants.baseUrl + NetworkingConstants.path + NetworkingConstants.apiKey + NetworkingConstants.pageNo + "\(page)")
        URLSession.shared.dataTask(with: urlStr!) { (data, response, error) in
            
            guard data != nil else{return}
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Movies.self, from: data!)
                
                if let result = responseModel.results
                {
                    self.results = result
                }
                completion(self.results)
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
