//
//  MyBookingsView.swift
//  Project
//
//  Created by CLChou on 2026/5/11.
//

import SwiftUI

// Shows current personal bookings
struct BookingItem: View {
    let session: BookSessionModel;
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 14) {
                Image(systemName: "calendar")
                    .frame(width: 24)
                    .foregroundColor(.accentColor)
                
                Text(
                    session.resvTime,
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
                
                Text("Table for \(session.numPeople)")
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

struct MyBookingsView: View {
    @Environment(BookingController.self) private var controller
    @State var myBookings: [BookSessionModel] = [];
    @State var pastBookings: [BookSessionModel] = [];
    @State var advance: Bool = false;
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("My Bookings").font(.system(size: 25, design: .serif).bold())
                
                LazyVStack(alignment: .center, spacing: 16) {
                    ForEach(myBookings, id: \.id) { session in
                        BookingItem(session: session)
                        .onTapGesture {
                            Task {
                                await controller.loadSession(sessionID: session.id)
                                advance = true;
                            }
                        }
                        .navigationDestination(isPresented: $advance) {
                            ConfirmationView();
                        }
                    }
                    Spacer();
                }.padding(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .task {
            myBookings = await loadBookings();
        }
    }
}

#Preview {
    MyBookingsView().environment(BookingController())
}
