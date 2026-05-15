//
//  TableModel.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// Status representation of a table
enum TableStatus: Equatable {
    case reserved
    case short(Int)  // Maybe one reserved for 2 hrs later (less than window)
    case available
    
    
}

// For visualising the table
struct TableModel: Codable, Identifiable {
    var id: UUID;
    var number: Int;
    var width: Int;
    var x: Double;
    var y: Double;
    
    /*
        1. min - max ppl seated is determined as 2w - 1 to 2w + 2 (two other edges).
        2. on view screen, rec'ed seatings will be displayed + name, which is 2w
        3. the table width will be determined by the w factor, can be determined later as we draw it out
     */
}
