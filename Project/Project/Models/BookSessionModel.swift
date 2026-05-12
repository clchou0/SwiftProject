//
//  BookSessionModel.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// Stores information about a dish with three variables; unique ID, dish ID and quantity
struct DishDetails: Codable, Identifiable {
    var id = UUID()
    let dishID: UUID
    var quantity: Int
}

// Contains details of a single booking
struct BookSessionModel: Codable, Identifiable {
    let id: UUID;
    // Table details
    var tableNo: Int?
    var resvTime: Date
    var numPeople: Int
    var bookingName: String
    
    // Default constructor
    init() {
        id = UUID();
        tableNo = nil
        resvTime = Date.tomorrow.setTime(hour: 11, minute: 0)
        numPeople = 1
        bookingName = ""
    }
    
    // Assists in pushing into db
    init(table: Int, Time: Date, People: Int, Name: String) {
        id = UUID()
        tableNo = table
        resvTime = Time
        numPeople = People
        bookingName = Name
    }
    
    // Ordering of each dish: currently not supported
//    var orderDetails: [DishDetails] = [];
}
