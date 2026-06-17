//
//  TablesChildView.swift
//  Project
//
//  Created by CLChou on 2026/5/5.
//

import SwiftUI

struct TablesChildView: View {
    @State private var control = FloorController();
    @State private var created: Bool = false;
    
    @Binding var selectedTable: Int?;
    let reservedTime: Date;
    let numPeople: Int;
    let sessionID: UUID?;
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            // Rules of how the table looks like
            ForEach(control.tables) { table in
                Rectangle()
                    .fill(control.color(tableNo: table.number))
                    .frame(width: 60, height: CGFloat((40 * table.width)))
                    .overlay(
                        VStack {
                            Text("\(table.number)")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                            Text("Fits: \(table.width * 2)")
                                .font(.system(size: 10, design: .serif))
                        }
                    )
                    .position(CGPoint(x: table.x, y: table.y))
                    .onTapGesture {
                        if (control.SelectTable(tableNo: table.number)) {
                            selectedTable = table.number;
                        }
                    }
            }
        }.frame(width: 300, height: 400)
        .task {
            control.tables = await loadTables();
            await control.FetchAvailableTables(forSession: sessionID, date: reservedTime, people: numPeople);
        }
    }
    
}

#Preview {
    TablesChildView(
        selectedTable: .constant(nil),
        reservedTime: Calendar.current.date(
            from: DateComponents(
                year: 2026,
                month: 5,
                day: 16,
                hour: 17,
                minute: 0
            )
        )!,
        numPeople: 3,
        sessionID: nil
    )
}
