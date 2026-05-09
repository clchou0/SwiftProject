//
//  FloorController.swift
//  Project
//
//  Created by CLChou on 2026/5/5.
//

import Foundation
import SwiftUI

// Controls all table availability related things
@Observable
class FloorController {
    // null: should not be in db
    
    var tables: [TableModel] =  [];
    
    var booking: [Int: TableStatus] = [
        1: .short("6:30"),
        2: .reserved,
        6: .available,
        5: .short("6:45")
    ];
    var selectedTable: Int?;
    
    init() {
        
    }
    
    // Visualizes availability
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
    
    // Get table attributes from db
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
        // 1. Look for eligible tables: under protocol
        
        // 2. Fetch availability of eligible tables
    }
    
    func SelectTable(tableNo: Int) {
        if let status = booking[tableNo] {
            switch (status) {
                case .short, .available:
                    if (self.selectedTable == tableNo) {
                        self.selectedTable = nil;
                    } else {
                        self.selectedTable = tableNo;
                    }
                case .reserved:
                    return
            }
        } else {
            // Not a table that i care
            return
        }
    }
    
    /**
        * Injects session: time and # ppl
        * Returns table statuses for all (only occupied)
        * Available to select table that is either green or yellow
     */
}
