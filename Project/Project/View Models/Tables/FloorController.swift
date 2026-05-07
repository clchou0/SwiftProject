//
//  FloorController.swift
//  Project
//
//  Created by CLChou on 2026/5/5.
//

import Foundation
import SwiftUI

// Controls all table related things
@Observable
class FloorController {
    // null: should not be in db
    let sessionID: UUID?;
    
    
    var tables: [TableModel] =  [
        TableModel(number: 1, width: 1, position: CGPoint(x: 60, y: 40)),
        TableModel(number: 2, width: 4, position: CGPoint(x: 60, y: 160)),
        TableModel(number: 3, width: 3, position: CGPoint(x: 60, y: 320)),
        TableModel(number: 4, width: 2, position: CGPoint(x: 150, y: 70)),
        TableModel(number: 5, width: 3, position: CGPoint(x: 150, y: 210)),
        TableModel(number: 6, width: 5, position: CGPoint(x: 240, y: 110)),
        TableModel(number: 7, width: 3, position: CGPoint(x: 240, y: 290))
    ];
    var booking: [Int: TableStatus] = [
        5: .short("6:45"),
        2: .reserved,
        1: .short("6:30")
    ];
    var selectedTable: Int?;
    
    init(sessionID: UUID?) {
        self.sessionID = sessionID;
        
    }
    
    // TODO: Collects tables and statuses from db
    
    // Visualizes availability
    func color (id: Int) -> Color {
        if (selectedTable == id) { return .orange; }
        
        if let status = booking[id] {
            switch (status) {
                case .short:
                    return .yellow
                case .reserved:
                    return .red
                case .available:
                    return .green
            }
        } else {
            return .gray
        }
    }
    
    func FetchTableDetails(date: Date, people: Int) {
        // rules: ppl >= 2w(max)- 3
        // Search from db
    }
    /**
        * Injects session: time and # ppl
        * Returns table statuses for all (only occupied)
        * Available to select table that is either green or yellow
     */
    
}
