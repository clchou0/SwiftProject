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
    var tables: [TableModel] =  [];
    var booking: [Int: TableStatus] = [:];
    var selectedTable: Int?;
    
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
    
    func FetchAvailableTables(forSession: UUID?, date: Date, people: Int) async {
        // Pushing eligible tables, ignoring non ones
        for table in self.tables {
            if table.width == (people + 1) / 2 {
                booking[table.number] = .available;
            }
        }
        
        let remote = await loadRemote();
        
        let earliestPrev: Date = Calendar.current.date(byAdding: .hour, value: -2, to: date)!;
        let earliestNext: Date = Calendar.current.date(byAdding: .hour, value: 1, to: date)!;
        let latestNext: Date = Calendar.current.date(byAdding: .hour, value: 2, to: date)!;
        
        for book in remote {
            // Ignore if i'm modifying current
            if let session = forSession, session == book.id { continue; }
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
    
    func SelectTable(tableNo: Int) -> Bool {
        if let status = booking[tableNo] {
            switch (status) {
            case .available, .short:
                    if (self.selectedTable == tableNo) {
                        self.selectedTable = nil;
                    } else {
                        self.selectedTable = tableNo;
                    }
                return true
                case .reserved:
                    return false;
            }
        } else {
            return false;
        }
    }
    
    /**
        * Injects session: time and # ppl
        * Returns table statuses for all (only occupied)
        * Available to select table that is either green or yellow
     */
}
