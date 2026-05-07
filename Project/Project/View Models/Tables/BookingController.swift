//
//  BookingController.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// All views that can be accessed


class BookingController {
    
    init() {
        // Fetch details if provided
    }
    
    // When first joined no uuid
    var sessionID: UUID?;
    var routes: Set<Route> = [];
    var currentSession: BookSessionModel?;
    // Helps visualize colors in booking map
    // var tableStatuses: [UUID: TableStatus] = [:];
    
    // When having tapped a valid session, load all details of it within the current scope
    func loadSession() {
        
    }
    
    // Goes thru all bookings to see if overlapped
    func fetchTableStatus() {
        
    }
    
}
