//
//  FloorController.swift
//  Project
//
//  Created by CLChou on 2026/5/5.
//

import Foundation
import SwiftUI

// Controls all table availability related functionality
@Observable
class FloorController {
    // null: should not be in the db
    
    var tables: [TableModel] =  [];
    
    var booking: [Int: TableStatus] = [:];
    var selectedTable: Int?;
    
    init() {
        
    }
    
    // This function visualises availability
    func color (tableNo: Int) -> Color {
        if (selectedTable == tableNo) { return .orange; }
        
        if let status = booking[tableNo] {
            switch (status) {
                case .short:
                    return .yellow
                case .reserved:
                    return .red
                case .available:
                    return .green
            }
        } else {
            // Not a table that i care
            return .gray
        }
    }
    
    // This function retrieves table attributes from the db
    func loadTables() {
        guard let data = UserDefaults.standard.data(forKey: "tables") else {
            return;
        }
        do {
            self.tables = try JSONDecoder().decode(
                [TableModel].self,
                from: data
            )
        } catch {
            print(error)
            return;
        }
    }
    
    func FetchAvailableTables(date: Date, people: Int) {
        // Pushing eligible tables, ignoring non ones
        for table in self.tables {
            if table.width == (people + 1) / 2 {
                booking[table.number] = .available;
            }
        }
        
        let remote = loadRemote();
        
        let earliestPrev: Date = Calendar.current.date(byAdding: .hour, value: -2, to: date)!;
        let earliestNext: Date = Calendar.current.date(byAdding: .hour, value: 1, to: date)!;
        let latestNext: Date = Calendar.current.date(byAdding: .hour, value: 2, to: date)!;
        
        for book in remote {
            // One of the valid tables
            if let tableNo = book.tableNo, booking[tableNo] != nil {
                if (earliestPrev <= book.resvTime  && book.resvTime < earliestNext) {
                    booking[tableNo] = .reserved;
                }
                else if (earliestNext <= book.resvTime && book.resvTime < latestNext) {
                    let mins: Int = Calendar.current.dateComponents(
                        [.minute],
                        from: book.resvTime,
                        to: latestNext
                    ).minute ?? 0;
                    
                    booking[tableNo] = .short(mins)
                }
            }
        }
        
    }
    
    // This function fetches the bookings from the local storage
    func loadRemote() -> [BookSessionModel] {
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
    
    // This function handles the user selecting a table on the map
    func SelectTable(tableNo: Int) -> Bool {
        if let status = booking[tableNo] {
            switch (status) {
                case .short, .available:
                    if (self.selectedTable == tableNo) {
                        self.selectedTable = nil;
                    } else {
                        self.selectedTable = tableNo;
                    }
                case .reserved:
                    return false;
            }
        } else {
            return false;
        }
        return true;
    }
    
    /**
        * Injects session: time and # ppl
        * Returns table statuses for all (only occupied)
        * Available to select table that is either green or yellow
     */
}
