//
//  TablesView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct TablesMainView: View {
    @Environment(BookingController.self) var controller;
    @State private var computedScale = 1.0;
    @State private var showPopup: Bool = false;
    
    var tableIndexBinding: Binding<Int?> {
        Binding(
            get: { controller.currentSession.tableNo },
            set: { controller.currentSession.tableNo = $0 }
        )
    }
    
    let serifFont: Font = .system(size: 20, design: .serif).bold();
    @State var dateString: String = "";
    var body: some View {
        VStack {
            Text("Booking for " + dateString).font(serifFont.bold())
            
            GeometryReader { geo in
                // Default restaurant ground
                let computedScale = min(geo.size.width / 300, geo.size.height / 400)
                
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0))
                    
                    TablesChildView(
                        selectedTable: tableIndexBinding,
                        reservedTime: controller.currentSession.resvTime,
                        numPeople: controller.currentSession.numPeople
                    )
                    .scaleEffect(computedScale)
                }
            }
            
            Text("Each reservation will be for 2 hours\n")
            Text("🟧: Selected Table")
            
            Button {
                if controller.currentSession.tableNo == nil {
                    showPopup = true
                } else {
                    controller.saveSession()
                }
            } label: {
                Text("Proceed to Confirmation")
                    .font(serifFont)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(PrimaryButtonStyle())
            .alert("You have to select a table", isPresented: $showPopup) {
                Button("OK", role: .cancel) {
                    showPopup = false
                }
            }
            
        }
        .padding(15)
        .onAppear {
            self.dateString = controller.currentSession.resvTime
                .formatted(
                    .dateTime
                        .day()
                        .month(.wide)
                        .hour()
                        .minute()
                )
        }
    }
    
}

#Preview {
    TablesMainView().environment(BookingController());
}
