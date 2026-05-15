//
//  ConfirmationView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(BookingController.self) private var controller
    @EnvironmentObject var HomeViewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var edit: Bool = false;
    
    private let serifFont: Font = .system(size: 25, design: .serif).bold()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 72))
                    .foregroundColor(.green)
                
                VStack(spacing: 8) {
                    Text("Booking Confirmed")
                        .font(.system(.largeTitle, design: .serif).bold())
                        .multilineTextAlignment(.center)
                    
                    Text("Your reservation has been successfully created.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 14) {
                        Image(systemName: "calendar")
                            .frame(width: 24)
                            .foregroundColor(.accentColor)
                        
                        Text(
                            controller.currentSession.resvTime,
                            format: .dateTime
                                .day()
                                .month(.abbreviated)
                                .hour()
                                .minute()
                        )
                    }
                    
                    HStack(spacing: 14) {
                        Image(systemName: "person.2")
                            .frame(width: 24)
                            .foregroundColor(.accentColor)
                        
                        Text("Table for \(controller.currentSession.numPeople)")
                    }
                    
                    if let tableNo = controller.currentSession.tableNo {
                        HStack(spacing: 14) {
                            Image(systemName: "square.grid.2x2")
                                .frame(width: 24)
                                .foregroundColor(.accentColor)
                            
                            Text("Table \(tableNo)")
                        }
                    }
                    
                    Divider()
                    
                    HStack(spacing: 14) {
                        Image(systemName: "number")
                            .frame(width: 24)
                            .foregroundColor(.secondary)
                        
                        Text(controller.currentSession.id.uuidString.prefix(8))
                            .foregroundColor(.secondary)
                    }
                }
                .font(.body)
                .padding(22)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                
                Spacer()
                
                Button {
                    edit = true;
                } label: {
                    Text("Edit details")
                        .font(serifFont)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(20)
            .navigationDestination(isPresented: $edit) {
                // UPDATE no argument should be needed
                BookDetailsView(session: controller.sessionID);
            }
        }
    }
}

#Preview {
    ConfirmationView()
        .environment(BookingController())
        .environmentObject(HomeViewModel())
}
