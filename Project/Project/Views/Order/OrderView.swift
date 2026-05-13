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
                    ForEach(itemsOnTheMenu) { menu in
                        HStack {
                            Image(systemName: "fork.knife")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                                .padding(10)
                                .background(Color(.systemGray5))
                            
                            VStack {
                                Text(menu.name)
                                    .font(.headline)
                                if let description = menu.description {
                                    Text(description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                            
                            Text("$15")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                        }
                        .padding(.horizontal)
                        if menu.id != itemsOnTheMenu.last?.id {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
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
