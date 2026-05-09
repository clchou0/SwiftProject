//
//  BookingController.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// All views that can be accessed


class BookingController {
    
    init(sessionID: UUID?) {
        // Fetch details if provided
        currentSession = BookSessionModel();
    }
    
    // When first joined no uuid
    var sessionID: UUID?;
    var currentSession: BookSessionModel;
    // Helps visualize colors in booking map
    
    // Saves the current booking
    func saveSession() {
        if (sessionID == nil) {
            
        }
        
        // Modify / push to both remote and local
    }
}
