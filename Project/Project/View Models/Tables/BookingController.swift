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
    func loadSession(sessionID: UUID?) async {
        if let id = sessionID {
            currentSession = await loadBookings().first(where: {$0.id == id})!
        } else {
            currentSession = BookSessionModel()
        }
    }
    
    // Saves the current booking
    func saveSession() {
        
        let decoder = JSONDecoder()
        
        var bookings: [BookSessionModel] = []
        var remote: [BookSessionModel] = []
        
        if let data = UserDefaults.standard.data(forKey: "bookings"),
           let decoded = try? decoder.decode([BookSessionModel].self, from: data) {
            bookings = decoded
        }
        
        if let data = UserDefaults.standard.data(forKey: "remote"),
           let decoded = try? decoder.decode([BookSessionModel].self, from: data) {
            remote = decoded
        }
        
        if sessionID == nil {
            bookings.append(currentSession)
            remote.append(currentSession)
        } else {
            // editing case
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
