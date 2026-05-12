//
//  ConfirmationView.swift
//  Project
//
//  Created by CLChou on 2026/5/2.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(BookingController.self) var controller
    @Environment(\.dismiss) private var dismissView
    //view for displaying the confirmation screen
    var body: some View {
            VStack(spacing: 25) {
                // success icon to display on top of device
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                    .padding(.top, 10)
                
                // text to tell user that booking has been confirmed
                Text("BOOKING HAS BEEN CONFIRMED!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // displays booking details
                VStack(alignment: .leading, spacing: 25) {
                    // displays date and time of the booking
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.accentColor)
                            .frame(width: 25)
                        Text(controller.currentSession.resvTime.formatted(date: .abbreviated, time: .shortened))
                            .font(.body)
                        Spacer()
                    }
                    
                    // displays the number of people in the booking
                    HStack {
                        Image(systemName: "person.2")
                            .foregroundColor(.accentColor)
                            .frame(width: 25)
                        //This if statement deals with the special case of whether the booking contains details for one person or more than one person
                        if controller.currentSession.numPeople == 1 {
                            Text("1 person")
                                .font(.body)
                        } else {
                            Text("\(controller.currentSession.numPeople) people")
                                .font(.body)
                            //obviously this change had to be done otherwise putting "1 people" or "2 person" would look silly
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    // this displays the booking UUID
                    HStack {
                        Image(systemName: "qrcode")
                            .foregroundColor(.accentColor)
                            .frame(width: 22)
                        Text("Booking ID: \(controller.currentSession.id.uuidString.prefix(8))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
                
                // the done button
                Button(action: {
                    dismissView()
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .padding()
        }
    }

#Preview {
        ConfirmationView()
            .environment(BookingController())
}
