//
//  ProfileView.swift
//  Project
//
//  Created by Jayden on 13/5/2026.
//

import Combine
import SwiftUI
 
struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(BookingController.self) private var bookingController
    @StateObject private var vm = ProfileViewModel()
 
    // bookings loaded from UserDefaults on appear
    @State private var myBookings: [BookSessionModel] = []
    @State private var showClearAlert = false
 
    // serif fonts used consistently across view
    private let serif: Font = .system(size: 20, design: .serif).bold()
    private let sectionSerif: Font = .system(size: 16, design: .serif).bold()
 
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24){
                    
                    avatarSection
                    detailsCard
                    bookingsSection
                    
                }
                
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 32)
                
            }
            
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading){
                    Button("Close") { dismiss() }
                }
                
                // toggles edit mode and switches to save button while editing
                ToolbarItem(placement: .navigationBarTrailing){
                    if vm.isEditing {
                        Button("Save"){vm.save()}
                            .fontWeight(.semibold)
                    } else {
                        Button("Edit"){ vm.isEditing = true }
                    }
                    
                }
            }
        }
        
        .task {myBookings = await loadBookings()}
    }
 
    // circule gradient avatar showing initials, with name and deets below
    private var avatarSection: some View {
        VStack(spacing: 10){
            ZStack {
                // gradient circle background for pfp
                Circle()
                    .fill(LinearGradient(
                        colors: [Color.accentColor, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                
                    .frame(width: 80, height: 80)
 
                // initials for pfp
                Text(initials)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
            }
 
            // only shows when a names been saved
            if !vm.name.isEmpty {
                Text(vm.name)
                    .font(.title3.weight(.semibold))
            }
            
            // only shows when an emails been saved
            if !vm.email.isEmpty {
                Text(vm.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }
        .padding(.top, 8)
    }
 
    // card containing editable name, email, and phone rows
    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 0){
            
            sectionHeader("Personal Details", icon: "person.fill")
 
            // each row shows a label and value and switches to a text field in edit mode
            VStack(spacing: 0){
                profileRow(
                    
                    icon: "person",
                    label: "Name",
                    value: $vm.name,
                    placeholder: "Your Name",
                    editing: vm.isEditing
                    
                )
                
                Divider().padding(.leading, 52)
 
                profileRow(
                    
                    icon: "envelope",
                    label: "Email",
                    value: $vm.email,
                    placeholder: "example@email.com",
                    editing: vm.isEditing,
                    keyboard: .emailAddress
                    
                )
                
                Divider().padding(.leading, 52)
 
                profileRow(
                    
                    icon: "phone",
                    label: "Phone",
                    value: $vm.phone,
                    placeholder: "04XX XXX XXX",
                    editing: vm.isEditing,
                    keyboard: .phonePad
                    
                )
            }
            
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
 
            // only visiblee in edit mode, reloads saved data and exits editing
            if vm.isEditing {
                Button {
                    vm.discardChanges()
                } label: {
                    Label("Discard changes", systemImage: "arrow.uturn.backward")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.top, 8)
            }
        }
    }
 
    // shows a tappable list of bookings, or an empty state placeholder
    private var bookingsSection: some View {
        
        VStack(alignment: .leading, spacing: 12){
            sectionHeader("Upcoming Bookings", icon: "calendar")
 
            if myBookings.isEmpty {
                emptyBookingsPlaceholder
            } else {
                // Each booking navigates to ConfirmationView and loads its session.
                VStack(spacing: 12){
                    ForEach(myBookings){ session in NavigationLink {
                        ConfirmationView().onAppear {
                            Task {await bookingController.loadSession(sessionID: session.id)}
                            }
                        
                        } label: {
                            BookingItem(session: session)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
 
    // shown when there are no bookings to display
    private var emptyBookingsPlaceholder: some View {
        
        VStack(spacing: 10){
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 36))
                .foregroundColor(.secondary)
            Text("No upcoming bookings")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(60)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private func sectionHeader(_ title: String, icon: String) -> some View {
        
        Label(title, systemImage: icon)
            .font(sectionSerif)
            .foregroundColor(.primary)
            .padding(.bottom, 6)
        
    }
 
    private func profileRow(
        
        icon: String,
        label: String,
        value: Binding<String>,
        placeholder: String,
        editing: Bool,
        keyboard: UIKeyboardType = .default
        
    ) -> some View {
        
        HStack(spacing: 14){

            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(.accentColor)
                .padding(.leading, 16)
 
            VStack(alignment: .leading, spacing: 2){
                
                // small caption label above the value.
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
 
                if editing {
                    
                    // editable text field with appropriate keyboard type
                    TextField(placeholder, text: value)
                        .keyboardType(keyboard)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(keyboard == .emailAddress ? .never : .words)
                        .disableAutocorrection(true)
                    
                } else {
                    Text(value.wrappedValue.isEmpty ? placeholder : value.wrappedValue)
                        .foregroundColor(value.wrappedValue.isEmpty ? .secondary : .primary)
                    
                }
            }
            
            Spacer()
            
        }
        .padding(.vertical, 12)
    }
 
    // extracts two initials from the username for the avatar
    private var initials: String {
        
        let words = vm.name.split(separator: " ")
        let letters = words.prefix(2).compactMap { $0.first }
        return letters.isEmpty ? "?" : String(letters).uppercased()
        
    }
}
 
#Preview {
    
    ProfileView()
        .environment(BookingController())
        .environmentObject(HomeViewModel())
    
}

