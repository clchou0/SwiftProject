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
            imagePath: "pizza"
        ),
        DishModel(
            name: "Ham and cheese sandwich",
            description: "Ham and cheese sandwich",
            imagePath: "hamandcheesesandwich"
        ),
        DishModel(
            name: "Chocolate cake",
            description: "Chocolate cake",
            imagePath: "chocolatecake"
        ),
        DishModel(
            name: "Steak",
            description: "Steak",
            imagePath: "steak"
        )
    ]
    
    var body: some View {
        // Contains a scroll box that has for each dish in the menu
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(itemsOnTheMenu) { menu in
                        HStack {
                            Image(menu.imagePath)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                            
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
