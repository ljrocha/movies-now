//
//  Date+Ext.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/1/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
