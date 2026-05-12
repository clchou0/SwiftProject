//
//  OrderView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct OrderView: View {
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
