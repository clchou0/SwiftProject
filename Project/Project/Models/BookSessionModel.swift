//
//  BookSessionModel.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation
// This enum represents the different stages of a booking, from processing to finished
enum BookStatus: String, Codable {
    case Booked; // Gotten into confirmation screen
    case Paid;
    case Finished;
}
// Stores information about a dish with three variables; unique ID, dish ID and quantity
struct DishDetails: Codable, Identifiable {
    let id = UUID();
    let dishID: UUID;
    var quantity: Int;
    // var notes: String;
}

// Contains details of a single booking
struct BookSessionModel: Codable, Identifiable {
    let id = UUID();
    
    // Table details
    var tableID: UUID?;
    var resvTime: Date?;
    var numPeople: Int?;
    var bookingName: String?;
    
    // Ordering of each dish: currently not supported
//    var orderDetails: [DishDetails] = [];
//    var status: BookStatus = BookStatus.Booked;
}
