//
//  FBConstants.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/12/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import UIKit

/*
 Considering we have only one view controller in the app, there is a common enum for constants.
 As the number of view controllers increase, we can categorize this enum to match respective elements.
*/

/// Enum containing constants
enum FBConstants {
    
    /// jSON file name
    static let jsonFileName = "mock"
    
    /// Height of table view section
    static let tableViewSectionHeight: CGFloat = 30.0
    
    /// Table view section title font size
    static let tableViewSectionTitleFontSize: CGFloat = 16.0
    
    /// View controller  navigation bar title font size
    static let navigationBarTitleFontSize: CGFloat = 24.0
    
    /// Image indicating event conflict
    static let conflictIconImageName = "event-conflict-icon.png"
    
    /// Alert message to show for conflicting events
    static let conflictAlertMessage = "You have conflicting events on this day!"
    
    /// Alert view ok button title
    static let alertOkButtonTitle = "Ok"
    
    /// EventsListViewController navigation bar title
    static let eventsListViewTitle = "Upcoming Events"
}
