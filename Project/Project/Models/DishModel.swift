//
//  DishModel.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import Foundation

// Defines a dish with a unique ID, image, name & description
struct DishModel: Codable, Identifiable {
    let id = UUID();
    let name: String;
    let description: String?;
    let imagePath: String;
}
