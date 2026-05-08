//
//  TablesChildView.swift
//  Project
//
//  Created by CLChou on 2026/5/5.
//

import SwiftUI

struct TablesChildView: View {
    var control: FloorController;
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            
            ForEach(control.tables) { table in
                Rectangle()
                    .fill(control.color(id: table.number))
                    .frame(width: 55, height: CGFloat((35 * table.width)))
                    .overlay(
                        VStack {
                            Text("\(table.number)")
                                .font(.system(size: 20, weight: .bold, design: .serif))
                            Text("Fits: \(table.width * 2)")
                                .font(.system(size: 10, design: .serif))
                        }
                    )
                    .position(table.position)
                    .onTapGesture {
                        control.selectedTable = table.number
                    }
            }
        }.frame(width: 300, height: 400)
    }
}

#Preview {
    TablesChildView(control: FloorController(sessionID: nil));
}
