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
                
        }
    }
}
// This structure is the entry point for the application.
