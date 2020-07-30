//
//  FBEventTableViewCell.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import UIKit

class FBEventTableViewCell: UITableViewCell {
    
    /// EventTableViewCell cell identifier
    static let eventTableViewCellIdentifier = "eventTableCell"
    
    /// Closure variable to pass around view model and view controller to show event conflict message when tapped on `conflictIndicatorButton`
    var showConflictMessage: (() -> Void)?
    
    /// Label to show event name
    @IBOutlet private weak var eventNameLabel: UILabel!
    
    /// Label to show start and end time of event
    @IBOutlet private weak var eventTimeLabel: UILabel!
    
    /// Button indicating conflict between events
    @IBOutlet private weak var conflictIndicatorButton: UIButton!
    
    /// Method to configure table view cell with Event struct
    /// - Parameter event: Event struct
    func configureCell(_ event: Event) {
        eventNameLabel.text = event.title
        eventTimeLabel.text = "\(event.start.getTime()) -- \(event.end.getTime())"
        conflictIndicatorButton.isHidden = !event.hasConflict
    }
    
    /// IBAction of `conflictIndicatorButton`
    /// - Parameter sender: UIButton
    @IBAction func conflictIndicatorButtonPressed(_ sender: UIButton) {
        showConflictMessage?()
    }
}
