//
//  DBFunctions.swift
//  Project
//
//  Created by CLChou on 2026/5/11.
//

import Foundation
import SwiftUI

// Loads tables in the restaurant
func loadTables() async -> [TableModel] {
    guard let data = UserDefaults.standard.data(forKey: "tables") else {
        return [];
    }
    do {
        return try JSONDecoder().decode(
            [TableModel].self,
            from: data
        )
    } catch {
        print(error)
        return []
    }
}

// Loads personal bookings
func loadBookings() async -> [BookSessionModel] {
    guard let data = UserDefaults.standard.data(forKey: "bookings") else {
        return [];
    }
    do {
        var bookings: [BookSessionModel] = try JSONDecoder().decode(
            [BookSessionModel].self,
            from: data
        )
        bookings = bookings.filter { $0.resvTime > Date() }
        bookings = bookings.sorted { $0.resvTime < $1.resvTime }
        
        
        return bookings
    } catch {
        print(error)
        return []
    }
}

// Loads bookings present in the database
func loadRemote() async -> [BookSessionModel] {
    guard let data = UserDefaults.standard.data(forKey: "remote") else {
        return [];
    }
    do {
        return try JSONDecoder().decode(
            [BookSessionModel].self,
            from: data
        )
    } catch {
        print(error)
        return []
    }
}

func resetTables() {
    UserDefaults.standard.removeObject(forKey: "tables");
    
    let tbs = [
        TableModel(id: UUID(), number: 1, width: 1, x: 60, y: 40),
        TableModel(id: UUID(), number: 2, width: 4, x: 60, y: 160),
        TableModel(id: UUID(), number: 3, width: 3, x: 60, y: 320),
        TableModel(id: UUID(), number: 4, width: 2, x: 150, y: 50),
        TableModel(id: UUID(), number: 5, width: 2, x: 150, y: 145),
        TableModel(id: UUID(), number: 6, width: 2, x: 150, y: 240),
        TableModel(id: UUID(), number: 7, width: 5, x: 240, y: 120),
        TableModel(id: UUID(), number: 8, width: 3, x: 240, y: 310)
    ];
    do {
        let data = try JSONEncoder().encode(tbs)
        UserDefaults.standard.set(data, forKey: "tables")
    } catch {
        print(error)
    }
}

func resetBookings() {
    UserDefaults.standard.removeObject(forKey: "bookings");
    let date: Date = Calendar.current.date(
        from: DateComponents(
            year: 2026,
            month: 5,
            day: 14,
            hour: 5,
            minute: 0
        )
    )!
    let bookings: [BookSessionModel] = [
        BookSessionModel(table: 4, Time: date, People: 3, Name: "Matthew"),
    ]
    do {
        let data = try JSONEncoder().encode(bookings)
        UserDefaults.standard.set(data, forKey: "bookings")
    } catch {
        print(error)
    }
}
    
func resetRemote() {
    UserDefaults.standard.removeObject(forKey: "remote");
    // 5/16 5pm
    
    let remote: [BookSessionModel] = [
        BookSessionModel(table: 4, Time: makeDate(hour: 17, minute: 0), People: 3, Name: "Matthew"),
        BookSessionModel(table: 5, Time: makeDate(hour: 18, minute: 0), People: 4, Name: "Jack"),
        BookSessionModel(table: 6, Time: makeDate(hour: 19, minute: 0), People: 4, Name: "Sarah")
    ]
    do {
        let data = try JSONEncoder().encode(remote)
        UserDefaults.standard.set(data, forKey: "remote")
    } catch {
        print(error)
    }
}

func makeDate(hour: Int, minute: Int = 0) -> Date {
    Calendar.current.date(
        from: DateComponents(
            year: 2026,
            month: 5,
            day: 22,
            hour: hour,
            minute: minute
        )
    )!
}


