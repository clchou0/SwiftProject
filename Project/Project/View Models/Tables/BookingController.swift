//
//  BookingController.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// All the views that can be accessed

@Observable
class BookingController {
    init() {
        
    }
    // When first joined, there is no UUID
    var sessionID: UUID? = nil;
    var currentSession: BookSessionModel = BookSessionModel();
    // Helps to visualise colors in booking map
    func loadSession(sessionID: UUID?) async {
        if let id = sessionID {
            currentSession = await loadBookings().first(where: {$0.id == id})!
            self.sessionID = id;
        } else {
            currentSession = BookSessionModel()
        }
    }
    
    // Saves the current booking to UserDefaults
    func saveSession() {
        
        let decoder = JSONDecoder()

        // load existing bookings
        var bookings: [BookSessionModel] = []
        var remote: [BookSessionModel] = []

        // load in person bookings
        if let data = UserDefaults.standard.data(forKey: "bookings"),
           let decoded = try? decoder.decode([BookSessionModel].self, from: data) {
            bookings = decoded
        }

        // load remotely made bookings
        if let data = UserDefaults.standard.data(forKey: "remote"),
           let decoded = try? decoder.decode([BookSessionModel].self, from: data) {
            remote = decoded
        }

        // add or update a booking of either type
        if sessionID != nil {
            bookings.removeAll { $0.id == sessionID }
            remote.removeAll { $0.id == sessionID }
        }
        bookings.append(currentSession)
        remote.append(currentSession)
        
        // saves an in person booking
        do {
            let data = try JSONEncoder().encode(bookings)
            UserDefaults.standard.set(data, forKey: "bookings")
        } catch {
            print(error)
        }

        // saves a remote booking
        do {
            let data = try JSONEncoder().encode(remote)
            UserDefaults.standard.set(data, forKey: "remote")
        } catch {
            print(error)
        }
    }
    
}
