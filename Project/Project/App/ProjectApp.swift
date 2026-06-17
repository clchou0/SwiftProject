//
//  ProjectApp.swift
//  Project
//
//  Created by CLChou on 2026/4/28.
//

import SwiftUI

@main
struct ProjectApp: App {
    @StateObject private var HViewModel = HomeViewModel()
    @State private var BookingViewModel = BookingController()
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environmentObject(HViewModel)
                .environment(BookingViewModel)
                .task{
                    if UserDefaults.standard.object(forKey: "tables") == nil { resetTables() }
                    if UserDefaults.standard.object(forKey: "bookings") == nil { resetBookings() }
                    if UserDefaults.standard.object(forKey: "remote") == nil { resetRemote() }
                }
        }
        
    }
    
}
// This structure is the entry point for the application.
