//
//  TablesChildView.swift
//  Project
//
//  Created by CLChou on 2026/5/5.
//

import SwiftUI

struct TablesChildView: View {
    @State var control: FloorController;
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
            
        }.frame(width: 1000, height: 700)
    }
}

#Preview {
    var control = FloorController();
    TablesChildView(control: control)
}
