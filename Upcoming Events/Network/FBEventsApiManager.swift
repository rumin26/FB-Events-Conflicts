//
//  FBEventsApiManager.swift
//  Upcoming Events
//
//  Created by Shah, Rumin on 4/11/20.
//  Copyright © 2020 Shah, Rumin. All rights reserved.
//

import Foundation

/// Class to manage network call to fetch upcoming events
class FBEventsApiManager {
    
    static let shared = FBEventsApiManager()
    
    private init() {}
    
    /// Network call to fetch upcoming events
    /// - Parameter completion: escaping closure with Result type
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: FBConstants.jsonFileName, withExtension: "json") {

            do {
                let data = try Data(contentsOf: url)
                let events = try JSONDecoder().decode([Event].self, from: data)
                
                completion(.success(events))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
