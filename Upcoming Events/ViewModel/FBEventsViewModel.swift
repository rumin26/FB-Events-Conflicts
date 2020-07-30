//
//  FBEventsViewModel.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import UIKit

/// View Model to help interaction between Event model's data and EventsListViewController
class FBEventsViewModel: NSObject {
    
    /// Dictionary to group array of Event struct based on start date
    private var eventsDict = [Date: [Event]]()
    
    /// Table view sections of start date
    var sections = [Date]()
    
    /// Closure to bind view model and EventsListViewController for showing alert of conflicting events
    var showConflictAlert: ((_ alert: UIAlertController) -> Void)?
    
    override init() {
        super.init()
        fetchUpcomingEvents()
    }
    
    /// Method to fetch upcoming events
    func fetchUpcomingEvents() {
        FBEventsApiManager.shared.fetchEvents { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let events):
                strongSelf.processEvents(events)
            case .failure(let error):
                // Handle error
                print("Error fetching events:\(error)")
            }
        }
    }
    
    /// Method to process successful api response of upcoming events api. This method helps form `eventsDict` and `sections`
    /// Iterates over array of events and group events based on start date.
    /// Sorts sections of start date in ascending order
    /// - Parameter events: Array of Event struct received from successful response of upcoming events api
    ///
    /// Time Complexity Analysis: Forming `eventsDict` takes O(e) where e is number of events, sorting of start date takes O(nlogn) where n is number of start dates, appending events in array takes O(1)
    /// Time Complexity: O(e) + 0(nlogn)
    private func processEvents(_ events: [Event]) {
        for event in events {
            eventsDict[event.start.getStringToDate(), default: []].append(event)
        }
        
        sections = (eventsDict.keys).sorted(by: <)
    }
    
    /// Method to detect conflict between events.
    /// Iterates over array of events under particular section
    /// - Parameter events: Array of events from particular section that is grouped by start date
    ///
    /// Time Complexity Analysis: Iterating over array of events in particular section takes O(n) where n is number of events, `max` takes O(1)
    /// Time Complexity: O(n)
    func checkForConflicts(_ events: inout [Event]) {
        /*
            `latestEndTime` keeps track of longest end time.
            For example:
            Event1 -- start: 12:30 PM, end: 8:00 PM
            Event2 -- start: 1:00 PM, end: 2:00 PM
            Event3 -- start: 3:00 PM, end: 6:00 PM
            
            All three events are conflicting as Event1 ends at 8:00 PM, while Event1 and Event2 starts before 8:00 PM.
            Event2 and Event3 are not conflicting among each other but they both conflict with Event1.
        */
        var latestEndTime = events[0].end.getStringToFullDate()
        for i in 1..<events.count {
            // if latestEndTime is more than start time of current event, there is a conflict.
            // Assume that no events will start and end on different days.
            if latestEndTime > events[i].start.getStringToFullDate() {
                events[i].hasConflict = true // mark current event as conflicting
                events[i - 1].hasConflict = true // mark previous event as conflicting
            }
            
            latestEndTime = max(events[i].end.getStringToFullDate(), latestEndTime) // keep track of longest end time
        }
    }
    
    /// Method to get event list of particular table view section
    /// - Parameter section: section number
    /// - Returns: Array of events
    /// Time Complexity Analysis: Fetching item from dictionary takes O(1)
    /// Time Complexity: O(1)
    func getSectionEvents(_ section: Int) -> [Event]? {
        return eventsDict[sections[section]]
    }
    
    /// Method to get particular event in table view from array of events after being sorted in chronological order.
    /// - Parameter indexPath: indexPath of table view
    /// - Returns: Event
    ///
    /// Time Complexity Analysis: sorting events in chronological order takes O(nlogn), where n is number of events in that particular section, checking conflicts take O(n)
    /// Time Complexity: O(n) + O(nlogn)  = O(nlogn)
    func getEvent(_ indexPath: IndexPath) -> Event? {
        let events = getSectionEvents(indexPath.section)
        if var data = events {
            data = data.sorted(by: {$0.start.getStringToFullDate() < $1.start.getStringToFullDate()})
            checkForConflicts(&data)
            return data[indexPath.row]
        }
        return nil
    }
    
    /// Method to show alert for conflict message
    /// - Parameter day: Start time
    /// - Returns: UIAlertController object
    private func conflictAlert(_ day: String) -> UIAlertController {
        let alert = UIAlertController(title: day, message: FBConstants.conflictAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: FBConstants.alertOkButtonTitle, style: .cancel))
        return alert
    }
}


extension FBEventsViewModel: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = getSectionEvents(section),
            !events.isEmpty {
            return events.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FBEventTableViewCell.eventTableViewCellIdentifier,
                                                    for: indexPath) as? FBEventTableViewCell {
            
            if let event = getEvent(indexPath) {
                cell.configureCell(event)
                
                cell.showConflictMessage = { [weak self] in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    let dayString = strongSelf.sections[indexPath.section].getDateToString()
                    strongSelf.showConflictAlert?(strongSelf.conflictAlert(dayString))
                }
                cell.layoutIfNeeded() // Cell will layout properly and maintains dynamic height of the cell if event name is very large
                return cell
            }
        }

        return UITableViewCell()
    }
}
