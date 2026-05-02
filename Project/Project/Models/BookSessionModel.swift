//
//  BookSessionModel.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

enum BookStatus: String, Codable {
    case Processing;
    case Booked; // Gotten into confirmation screen
    case Paid;
    case Finished;
}

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
    var name: String?;
    var phone: String?;
    var email: String?;
    var resvTime: Date?;
    var numPeople: Int?;
    
    // Order Details
    var orderDetails: [DishDetails] = [];
    var status: BookStatus = BookStatus.Processing;
}
