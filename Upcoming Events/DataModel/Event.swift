//
//  Event.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import Foundation

/// Event  model
struct Event: Decodable {
    
    /// Event title
    let title: String
    
    /// Event start date string
    let start: String
    
    /// Event end date string
    let end: String
    
    /// Variable to check conflict among events
    var hasConflict: Bool = false
}

extension Event {
    /// Coding Key enum to decode only title, start and end
    enum Keys: CodingKey {
        case title
        case start
        case end
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        // For some reason api can mess up and title may not come in response.
        // For our parsing to successfully work, we can check with `decodeIfPresent`.
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Some Event"
        self.start = try container.decode(String.self, forKey: .start)
        self.end = try container.decode(String.self, forKey: .end)
    }
}

// Assuming two events can not have same title, Event struct is conform to Equatable
extension Event: Equatable {
    /// Event is conform to Equatable
    /// - Parameters:
    ///   - lhs: Event
    ///   - rhs: Event
    /// - Returns: Bool -  A check if two Event are equal
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.title == rhs.title
    }
}
