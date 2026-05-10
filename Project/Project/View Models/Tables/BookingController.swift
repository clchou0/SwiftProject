//
//  BookingController.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// All views that can be accessed

@Observable
class BookingController {
    init() {
        
    }
    // When first joined no uuid
    var sessionID: UUID? = nil;
    var currentSession: BookSessionModel = BookSessionModel();
    // Helps visualize colors in booking map
    func loadSession(sessionID: UUID?) {
        
        // Create new default version if not asked to load
        currentSession = BookSessionModel();
    }
    
    
    // Saves the current booking
    func saveSession() {
        var bookings = UserDefaults.standard.array(forKey: "bookings") as? [BookSessionModel] ?? [];
        var remote = UserDefaults.standard.array(forKey: "remote") as? [BookSessionModel] ?? [];
        if (sessionID == nil) {
            bookings.append(currentSession);
            remote.append(currentSession);
        } else {
            // case editing
        }
        
        do {
            let data = try JSONEncoder().encode(bookings)
            UserDefaults.standard.set(data, forKey: "bookings")
        } catch {
            print(error)
        }
        do {
            let data = try JSONEncoder().encode(remote)
            UserDefaults.standard.set(data, forKey: "remote")
        } catch {
            print(error)
        }
    }
    
}
