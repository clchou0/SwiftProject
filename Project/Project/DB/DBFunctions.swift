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
        return try JSONDecoder().decode(
            [BookSessionModel].self,
            from: data
        )
    } catch {
        print(error)
        return []
    }
}

// Loads bookings present in the DB
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


