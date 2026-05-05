//
//  TablesView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct TablesMainView: View {
    var body: some View {
        VStack {
            Text("Booking for 16 May 8:00PM")
                .font(.system(size: 25, design: .serif)).bold()
                .foregroundStyle(Color.green)
            
            GeometryReader { geo in
                // Default restaurant ground
                let scale = min(
                    geo.size.width / 1000,
                    geo.size.height / 700
                )
                
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                    
                    // ChildView()
                }
            }
        }
    }
}

#Preview {
    TablesMainView()
}
