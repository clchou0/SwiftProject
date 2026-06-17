//
//  DebugView.swift
//  Project
//
//  Created by CLChou on 2026/5/9.
//

import SwiftUI

enum Display {
    case table;
    case booking;
    case remote;
}

// Visualizing db when editing, shows data of table, booking & remote
struct DebugView: View {
    @State var tables: [TableModel] = []
    @State var bookings: [BookSessionModel] = []
    @State var remote: [BookSessionModel] = []
    
    @State var display: Display = .table;
    var body: some View {
        
        VStack {
            HStack {
                Button("TABLE") {
                    display = .table;
                    Task {
                        tables = await loadTables();
                    }
                }
                Button("BOOKING") {
                    display = .booking
                    Task {
                        bookings = await loadBookings();
                    }
                }
                Button("REMOTE") {
                    display = .remote
                    Task {
                        remote = await loadRemote();
                    }
                }
            }
            
            Spacer()
            
            switch(display) {
            case .table:
                List(self.tables) { table in
                    VStack (alignment: .leading) {
                        Text("Table \(table.number)\t\tWidth: \(table.width)")
                        Text("Position: \(table.x, specifier: "%.0f"), \(table.y, specifier: "%.0f")")
                    }
                }
            case .booking:
                List(self.bookings) { booking in
                    VStack (alignment: .leading) {
                        Text("Booking at \(booking.resvTime, format: .dateTime.day().month(.wide).hour().minute())");
                        Text("Table for \(booking.numPeople) number \(booking.tableNo ?? -1)");
                        Text(booking.id.uuidString.prefix(8))
                    }
                }
            
            case .remote:
                List(self.remote) { booking in
                    VStack (alignment: .leading) {
                        Text("Booking at \(booking.resvTime, format: .dateTime.day().month(.wide).hour().minute())");
                        Text("Table for \(booking.numPeople) number \(booking.tableNo ?? -1)");
                        Text(booking.id.uuidString.prefix(8))
                    }
                }
            }
            
            Button {
                switch display {
                case .table: resetTables();
                case .booking: resetBookings();
                case .remote: resetRemote();
                }
            } label: {
                switch (display) {
                case .table: Text("Reset Tables");
                case .booking: Text("Reset Bookings");
                case .remote: Text("Reset Remote");
                }
            }
        }
    }
        
    
    
    func resetTables() {
        UserDefaults.standard.removeObject(forKey: "tables");
        
        let tbs = [
            TableModel(id: UUID(), number: 1, width: 1, x: 60, y: 40),
            TableModel(id: UUID(), number: 2, width: 4, x: 60, y: 160),
            TableModel(id: UUID(), number: 3, width: 3, x: 60, y: 320),
            TableModel(id: UUID(), number: 4, width: 2, x: 150, y: 50),
            TableModel(id: UUID(), number: 5, width: 2, x: 150, y: 145),
            TableModel(id: UUID(), number: 6, width: 2, x: 150, y: 240),
            TableModel(id: UUID(), number: 7, width: 5, x: 240, y: 120),
            TableModel(id: UUID(), number: 8, width: 3, x: 240, y: 310)
        ];
        do {
            let data = try JSONEncoder().encode(tbs)
            UserDefaults.standard.set(data, forKey: "tables")
        } catch {
            print(error)
        }
    }
    
    func resetBookings() {
        UserDefaults.standard.removeObject(forKey: "bookings");
    }
        
    func resetRemote() {
        UserDefaults.standard.removeObject(forKey: "remote");
        // 5/16 5pm
        
        let remote: [BookSessionModel] = [
            BookSessionModel(table: 4, Time: makeDate(hour: 17, minute: 0), People: 3, Name: "Matthew"),
            BookSessionModel(table: 5, Time: makeDate(hour: 18, minute: 0), People: 4, Name: "Jack"),
            BookSessionModel(table: 6, Time: makeDate(hour: 19, minute: 0), People: 4, Name: "Sarah")
        ]
        do {
            let data = try JSONEncoder().encode(remote)
            UserDefaults.standard.set(data, forKey: "remote")
        } catch {
            print(error)
        }
    }
    
    func makeDate(hour: Int, minute: Int = 0) -> Date {
        Calendar.current.date(
            from: DateComponents(
                year: 2026,
                month: 5,
                day: 16,
                hour: hour,
                minute: minute
            )
        )!
    }
    
}

#Preview {
    DebugView()
}
