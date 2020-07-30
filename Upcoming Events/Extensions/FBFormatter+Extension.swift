//
//  FBFormatter+Extension.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import Foundation

extension Formatter {
    
    // Custom Date Formatters to format date
    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        return formatter
    }()
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm:ss a"
        return formatter
    }()
}
