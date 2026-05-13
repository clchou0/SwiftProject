//
//  ProfileView.swift
//  Project
//
//  Created by Jayden on 13/5/2026.
//

import Combine
import SwiftUI
 
final class ProfileViewModel: ObservableObject {
    private let detailsKey = "userDetails"
 
    @Published var name: String  = ""
    @Published var email: String = ""
    @Published var phone: String = ""
 
    // True while the user is editing their details.
    @Published var isEditing: Bool = false
 
    init() {load()}
 
    func load(){
        guard let data = UserDefaults.standard.data(forKey: detailsKey),
              let decoded = try? JSONDecoder().decode(StoredDetails.self, from: data)
        else {return}
        
        name  = decoded.name
        email = decoded.email ?? ""
        phone = decoded.phone ?? ""
        
    }
 
    func save(){
        
        let details = StoredDetails(name: name, email: email.isEmpty ? nil : email, phone: phone.isEmpty ? nil : phone)
        
        if let data = try? JSONEncoder().encode(details){
            UserDefaults.standard.set(data, forKey: detailsKey)
        }
        
        isEditing = false
        
    }
 
    func discardChanges(){
        load()
        isEditing = false
    }
 
    // Codable counterpart for DetailsModel
    private struct StoredDetails: Codable {
        
        var name: String
        var email: String?
        var phone: String?
        
    }
}
 
struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(BookingController.self) private var bookingController
    @StateObject private var vm = ProfileViewModel()
 
    @State private var myBookings: [BookSessionModel] = []
    @State private var showClearAlert = false
 
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
 
    private var avatarSection: some View {
        VStack(spacing: 10){
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [Color.accentColor, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                
                    .frame(width: 80, height: 80)
 
                Text(initials)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
            }
 
            if !vm.name.isEmpty {
                Text(vm.name)
                    .font(.title3.weight(.semibold))
            }
            
            if !vm.email.isEmpty {
                Text(vm.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }
        .padding(.top, 8)
    }
 
    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 0){
            
            sectionHeader("Personal Details", icon: "person.fill")
 
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
 
            if vm.isEditing {
                Button("Discard changes"){vm.discardChanges()}
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 6)
            }
        }
    }
 
    private var bookingsSection: some View {
        
        VStack(alignment: .leading, spacing: 12){
            sectionHeader("Upcoming Bookings", icon: "calendar")
 
            if myBookings.isEmpty {
                emptyBookingsPlaceholder
            } else {
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
                
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
 
                if editing {
                    
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

