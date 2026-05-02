//
//  TableModel.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

struct TableModel: Codable, Identifiable {
    let id = UUID();
    let name: String;
    let tableWidth: Int;
    let position: CGPoint;
    
    /**
        1. min - max ppl seated is determined as 2w - 1 to 2w + 2 (two other edges).
        2. on view screen, rec'ed seatings will be displayed + name, which is 2w
        3. the table width will be determined by the w factor, can be determined later as we draw it out
     */
}
