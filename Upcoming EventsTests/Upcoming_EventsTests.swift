//
//  Upcoming_EventsTests.swift
//  Upcoming EventsTests
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import XCTest
@testable import Upcoming_Events

class Upcoming_EventsTests: XCTestCase {
    
    private let viewModel = FBEventsViewModel()
    private var events: [Event] = []
    
    override func setUp() {
        let event1 = Event(title: "Football Game", start: "November 3, 2018 6:14 PM", end: "November 3, 2018 9:44 PM")
        let event2 = Event(title: "Friends Hangout", start: "November 3, 2018 9:14 PM", end: "November 3, 2018 10:44 PM")
        
        let event3 = Event(title: "Yoga", start: "November 3, 2018 6:15 AM", end: "November 3, 2018 7:00 AM")
        let event4 = Event(title: "Gym", start: "November 3, 2018 9:14 AM", end: "November 3, 2018 10:44 AM")
        
        events.append(event1)
        events.append(event2)
        events.append(event3)
        events.append(event4)
    }

    override func tearDown() {}

    func testEventSortAndConflicts() {
        
        events = events.sorted(by: {$0.start.getStringToFullDate() < $1.start.getStringToFullDate()})
        viewModel.checkForConflicts(&events)
        
        XCTAssertEqual(events[0].title, "Yoga")
        XCTAssertEqual(events[1].title, "Gym")
        XCTAssertEqual(events[2].title, "Football Game")
        XCTAssertEqual(events[3].title, "Friends Hangout")
        
        XCTAssertEqual(events[0].hasConflict, false)
        XCTAssertEqual(events[1].hasConflict, false)
        XCTAssertEqual(events[2].hasConflict, true)
        XCTAssertEqual(events[3].hasConflict, true)

    }
}
