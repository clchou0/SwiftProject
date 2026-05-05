//
//  FloorController.swift
//  Project
//
//  Created by CLChou on 2026/5/5.
//

import Foundation

// Controls all table related things
@Observable
class FloorController {
    // Collects list of tables
    var tables: [TableModel] = [];
    // Collects booking statuses, others all avaulable
    var booking: [UUID: TableStatus] = [:];
    
    /**
        * Injects session: time and # ppl
        * Returns table statuses for all (only occupied)
        * Available to select table that is either green or yellow
     */
    
}
