//
//  TablesView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct TablesMainView: View {
    @State private var computedScale = 1.0;
    let date = Date.tomorrow.setTime(hour: 12, minute: 18)
    let serifFont: Font = .system(size: 20, design: .serif).bold();
    var body: some View {
        VStack {
            Text("Booking for 16 May 8:00PM")
                .font(.system(.title, design: .serif).bold())
            
            GeometryReader { geo in
                // Default restaurant ground
                let computedScale = min(
                    geo.size.width / 300,
                    geo.size.height / 400
                )
                
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0))
                    TablesChildView(control: FloorController(sessionID: nil)).scaleEffect(computedScale)
                }
            }
            Button {
                print("Hello")
            } label: {
                Text("Proceed to Booking").font(serifFont)
                    .frame(maxWidth: .infinity)
                    .padding()
            }.buttonStyle(PrimaryButtonStyle())
        }.padding(15)
    }
}

#Preview {
    TablesMainView()
}
