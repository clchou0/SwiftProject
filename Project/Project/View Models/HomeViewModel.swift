//
//  HomeViewModel.swift
//  Project
//
//  Created by Mikhail Zhelnin on 2/5/2026.
//
import Foundation
import Combine 
import SwiftUI

final class HomeViewModel: ObservableObject {
    // UI state for sheets and alerts
    @Published var isBookingPresented: Bool = false
    @Published var isOrderPresented: Bool = false
    @Published var isProfilePresented: Bool = false

    // Simple actions
    func bookTable() { isBookingPresented = true }
    func orderNow() { isOrderPresented = true }
    func openProfile() { isProfilePresented = true }
}
