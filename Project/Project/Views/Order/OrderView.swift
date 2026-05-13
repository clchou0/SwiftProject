//
//  OrderView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct OrderView: View {
    // sample menu for testing
    let itemsOnTheMenu: [DishModel] = [
        DishModel(
            name: "Pizza",
            description: "Pizza",
            imagePath: ""
        ),
        DishModel(
            name: "Cheese",
            description: "Cheese",
            imagePath: ""
        ),
        DishModel(
            name: "Cake",
            description: "Cake",
            imagePath: ""
        ),
        DishModel(
            name: "Steak",
            description: "Steak",
            imagePath: ""
        )
    ]
    
    var body: some View {
        // Contains a scroll box that has for each dish in the menu
        NavigationStack {
            ScrollView {
                VStack {
                    
                }
            }
            .navigationTitle("RESTAURANT MENU")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    OrderView()
}
