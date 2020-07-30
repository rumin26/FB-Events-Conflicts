//
//  FBString+Date.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import Foundation

extension String {
    
    /// Converts full string of date from api response to full date
    /// - Returns: Converted string to date
    func getStringToFullDate() -> Date {
        if let date = Formatter.custom.date(from: self) {
            let convertedDateFormatter = DateFormatter()
            convertedDateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
        
            if let convertedDate = convertedDateFormatter.date(from: convertedDateFormatter.string(from: date)) {
                return convertedDate
            }
        }
        
        return Date()
    }
    
    /// Converts string from  api response to date.
    /// - Returns: Converted string to date
    func getStringToDate() -> Date {
        if let date = Formatter.custom.date(from: self) {
            let convertedDateFormatter = DateFormatter()
            convertedDateFormatter.dateFormat = "MMMM d, yyyy"
            
            if let convertedDate = convertedDateFormatter.date(from: convertedDateFormatter.string(from: date)) {
                return convertedDate
            }
        }
        
        return Date()
    }
    
    
    /// Converts start and end
    /// For example: November 8, 2018 7:30 PM to 7:30 PM
    /// - Returns: Converted string
    func getTime() -> String {
        if let date = Formatter.custom.date(from: self) {
            let convertedTimeFormatter = DateFormatter()
            convertedTimeFormatter.dateFormat = "h:mm a"
            return convertedTimeFormatter.string(from: date)
        }
        
        return ""
    }
}

extension Date {
    
    /// Converts date to string
    /// - Returns: converted date to string
    func getDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd h:mm:ss a"
        let date = dateFormatter.string(from: self)
        
        if let customString = Formatter.formatter.date(from: date) {
            let convertedTimeFormatter = DateFormatter()
            convertedTimeFormatter.dateFormat = "MMMM d, yyyy"
            return convertedTimeFormatter.string(from: customString)
        }
        
        return ""
    }
}
