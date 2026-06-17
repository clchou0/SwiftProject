//
//  ProfileViewModel.swift
//  Project
//
//  Created by CLChou on 2026/5/15.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    private let detailsKey = "userDetails"
 
    @Published var name: String  = ""
    @Published var email: String = ""
    @Published var phone: String = ""
 
    
    @Published var isEditing: Bool = false
 
    init() {load()}
 
    // reads saved details from UserDefaults and populates the published propertes
    func load(){
        guard let data = UserDefaults.standard.data(forKey: detailsKey),
              let decoded = try? JSONDecoder().decode(ProfileModel.self, from: data)
        else {return}
        
        name  = decoded.name
        email = decoded.email ?? ""
        phone = decoded.phone ?? ""
        
    }
 
    func save(){
        
        let details = ProfileModel(name: name, email: email.isEmpty ? nil : email, phone: phone.isEmpty ? nil : phone)
        
        if let data = try? JSONEncoder().encode(details){
            UserDefaults.standard.set(data, forKey: detailsKey)
        }
        
        isEditing = false
        
    }
 
    // reloads saved details
    func discardChanges(){
        load()
        isEditing = false
    }
}
