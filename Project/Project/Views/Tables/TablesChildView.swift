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
    init() {
        control.loadTables();
        created = true
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            Text(String(self.created));
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
                        control.SelectTable(tableNo: table.number)
                    }
            }
        }.frame(width: 300, height: 400)
        .onAppear {
            control.loadTables();
            created = true
        }
}
}

#Preview {
    TablesChildView();
}
