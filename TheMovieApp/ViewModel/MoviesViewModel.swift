//
//  MoviesViewModel.swift
//  TheMovieApp
//
//  Created by Nitz on 25/06/20.
//  Copyright © 2020 TM. All rights reserved.
//

import Foundation

class MoviesViewModel {
    
    // Mark: Formatting number for likes and comments
    func formatNumber(_ n: Int) -> String {
        
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        
        switch num {
            
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"
            
        case 0...:
            return "\(n)"
            
        default:
            return "\(sign)\(n)"
        }
    }
}

extension Double {
        
    func truncate(places: Int) -> Double {
        
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
        
    }
}

extension String {
    func toDate(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        dateFormatter.dateFormat = "dd MMM,YYYY"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
