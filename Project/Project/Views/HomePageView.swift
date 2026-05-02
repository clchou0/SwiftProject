//
//  HomePageView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var HomeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    colors: [Color(.systemGroupedBackground), Color(.secondarySystemGroupedBackground)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        headerSection
                        heroCard
                        actionButtons
                        footerInfo
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 18)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $HomeViewModel.isBookingPresented) {
                PlaceholderSheet(title: "Book a Table")
            }
            .sheet(isPresented: $HomeViewModel.isOrderPresented) {
                PlaceholderSheet(title: "Order Now")
            }
            .sheet(isPresented: $HomeViewModel.isProfilePresented) {
                PlaceholderSheet(title: "Profile")
            }
        }
    }
    
    // Header
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Good evening")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("El Restaurant")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.primary)
            }
            Spacer()
            HStack(spacing: 12) {
                Button(action: HomeViewModel.openProfile) {
                    Image(systemName: "person.crop.circle")
                        .font(.title2)
                        .padding(8)
                        .background(Color(.systemBackground).opacity(0.6))
                        .clipShape(Circle())
                }
                Button(action: { /* search */ }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .padding(8)
                        .background(Color(.systemBackground).opacity(0.6))
                        .clipShape(Circle())
                }
            }
        }
    }
    
    // Hero card
    private var heroCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Tonight's Special")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Chef's selection of seasonal dishes")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                Spacer()
                Image(systemName: "sparkles")
                    .font(.title)
                    .foregroundColor(.white.opacity(0.95))
                    .padding(10)
                    .background(Color.white.opacity(0.12))
                    .clipShape(Circle())
            }
            Text("Reserve a table or order for pickup")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(colors: [Color.accentColor, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 6)
        )
    }
    
    // Buttons
       private var actionButtons: some View {
           HStack(spacing: 12) {
               Button(action: HomeViewModel.bookTable) {
                   HStack {
                       Image(systemName: "calendar")
                       Text("Book a Table").fontWeight(.semibold)
                   }
                   .frame(maxWidth: .infinity)
                   .padding()
               }
               .buttonStyle(PrimaryButtonStyle())

               Button(action: HomeViewModel.orderNow) {
                   HStack {
                       Image(systemName: "bag")
                       Text("Order Now").fontWeight(.semibold)
                   }
                   .frame(maxWidth: .infinity)
                   .padding()
               }
               .buttonStyle(SecondaryButtonStyle())
           }
       }

    
       // Footer
       private var footerInfo: some View {
           VStack(spacing: 8) {
               Divider().opacity(0.08)
               Text("Open today 11:00 AM — 10:00 PM")
                   .font(.footnote)
                   .foregroundColor(.secondary)
           }
           .padding(.top, 8)
       }
   }

// Placeholder sheet used for demo
struct PlaceholderSheet: View {
    let title: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(title).font(.title2.weight(.bold))
                Text("Placeholder. Implement the real flow later.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                Button("Close") { dismiss() }
                    .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Button styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accentColor)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .shadow(color: Color.black.opacity(0.18), radius: 6, x: 0, y: 4)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground).opacity(0.9))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary.opacity(0.06), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView().environmentObject(HomeViewModel())
    }
}
