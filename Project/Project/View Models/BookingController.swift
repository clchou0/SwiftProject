//
//  BookingController.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// All views that can be accessed
enum Route: Hashable {
    case home
    case tables
    case order      // sessionID
    case checkout
}

enum TableStatus {
    case reserved
    case short  // Maybe one reserved for 2 hrs later (less than window)
    case available
}

class BookingController {
    
    init() {
        // Fetch details if provided
    }
    
    // When first joined no uuid
    var sessionID: UUID?;
    var routes: Set<Route> = [];
    var currentSession: BookSessionModel?;
    // Helps visualize colors in booking map
    var tableStatuses: [UUID: TableStatus] = [:];
    
    // When having tapped a valid session, load all details of it within the current scope
    func loadSession() {
        
    }
    
    // Goes thru all bookings to see if overlapped
    func fetchTableStatus() {
        
    }
    
}
