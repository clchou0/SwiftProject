//
//  BookDetailsView.swift
//  Project
//
//  Created by CLChou on 2026/5/6.
//

import SwiftUI

extension Date {
    static var today: Date { Date() }
    
    static var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    func setTime(hour: Int, minute: Int) -> Date {
        Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
    }
}

func DateComp (date: Date, component: Calendar.Component) -> Int {
    return Calendar.current.component(component, from: date);
}

// Gets the earliest available: an hour from now
func EarliestBooking() -> Date {
    let hour = Calendar.current.component(.hour, from: Date.now);
    var minute = Calendar.current.component(.minute, from: Date.now);
    
    // After latest resv tonight
    if (hour >= 20) {
        return Date.tomorrow.setTime(hour: 11, minute: 0);
    }
    // Earliest resv today
    if (hour < 10) {
        return Date.today.setTime(hour: 11, minute: 0);
    }
    // Nearest teen
    minute = ((minute + 9) / 10) * 10
    
    if (minute == 60) {
        return Date.today.setTime(hour: hour + 2, minute: 0)
    }
    return Date.today.setTime(hour: hour + 1, minute: minute)
}

struct BookDetailsView: View {
    @Environment(BookingController.self) var control;
    let sessionID: UUID?;
    
    // UPDATE: This should not be required if connected to homepage
    init(session: UUID?) {
        sessionID = session;
    }
    
    let serifFont: Font = .system(size: 20, design: .serif).bold();
    @State var dateSelect: Bool = true;
    @State var proceed: Bool = false;
    
    var date: Binding<Date> {
        Binding(
            get: { control.currentSession.resvTime },
            set: { control.currentSession.resvTime = $0 }
        )
    }
    
    // HH:MM variable modifications
    var hourBinding: Binding<Int> {
        Binding(
            get: { Calendar.current.component(.hour, from: date.wrappedValue) },
            set: { updateDate(hour: $0) }
        )
    }
    
    var minuteBinding: Binding<Int> {
        Binding(
            get: { Calendar.current.component(.minute, from: date.wrappedValue) },
            set: { updateDate(minute: $0) }
        )
    }
    
    // Date related components
    let name = "Marcus"
    let today = Calendar.current.startOfDay(for: Date())
    // 3 mnths from today
    let upLimitDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())!
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
//                if let id = control.sessionID { Text(id.uuidString.prefix(8)); }
//                Text("Booking for \(name)").font(serifFont);
                
                DateTitleRow;

                // Collapsed or not
                if (dateSelect) { DateSelection }
                else { DateVisualizer }
                
                Text("Time").font(serifFont);
                TimePicker;
                
                Text("Table For: \(control.currentSession.numPeople)").font(serifFont);
                TableSelection;
                
                ProceedButton.navigationDestination(isPresented: $proceed) {
                    TablesMainView();
                }
                Text("Dining time will be up to 2 hours")
                
            }.padding(15)
        }
        .onAppear {
            Task {
                await control.loadSession(sessionID: sessionID);
            }
        }
    }
    
    var DateTitleRow: some View {
        HStack {
            Spacer();
            Text("Date").font(serifFont);
            Spacer();
            
            Button {
                dateSelect = !dateSelect;
            } label: {
                if (dateSelect) { Image(systemName: "chevron.up")}
                else { Image(systemName: "chevron.down") }
            }
        }
    }
    
    var DateSelection: some View {
        DatePicker(
            "Start Date",
            selection: date,
            in: today...upLimitDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .tint(.blue).bold()
        .onChange(of: date.wrappedValue) { _, newValue in
            // Snaps back to earliest possible booking
            if (date.wrappedValue < EarliestBooking()) {
                date.wrappedValue = EarliestBooking();
            }
        }
   
    }
    
    var DateVisualizer: some View {
        // Date + Time
        
        if Calendar.current.isDateInToday(date.wrappedValue) {
            Text("Today").font(serifFont).foregroundStyle(.blue);
        } else if Calendar.current.isDateInTomorrow(date.wrappedValue) {
            Text("Tomorrow").font(serifFont).foregroundStyle(.blue);
        } else {
            Text(date.wrappedValue.formatted(
                .dateTime
                .weekday(.wide)
                .day()
                .month(.abbreviated)
            )).font(serifFont).foregroundStyle(.blue);
        }
    }
    
    var TimePicker: some View {
        HStack {
            Picker(
                selection: hourBinding,
                label: Text("")
            ) {
                ForEach(11...20, id: \.self) { i in
                    Text("\(i)").tag(i).font(serifFont)
                }
            }
            .pickerStyle(.wheel)
            .frame( width: 60, height: 80)
            
            Text(":").font(serifFont);
            
            Picker(
                selection: minuteBinding,
                label: Text("")
            ) {
                ForEach([0,10,20,30,40,50], id: \.self) { i in
                    if (i == 0) { Text("00").tag(i).font(serifFont) }
                    else { Text("\(i)").tag(i).font(serifFont) }
                }
            }
            .pickerStyle(.wheel)
            .frame( width: 60, height: 80)
            
        }
    }
    
    var TableSelection: some View {
        Slider(
            value: Binding(
                get: { Double(control.currentSession.numPeople) },
                set: { (control.currentSession.numPeople) = Int($0) }
            ),
            in: 1...10,
            step: 1
        )
    }
    
    var ProceedButton: some View {
        Button {
            proceed = true;
        } label: {
            Text("Proceed to Booking").font(serifFont)
                .frame(maxWidth: .infinity)
                .padding()
        }.buttonStyle(PrimaryButtonStyle())
    }
    
    func updateDate(hour: Int? = nil, minute: Int? = nil) {
        let calendar = Calendar.current

        let currentHour = calendar.component(.hour, from: date.wrappedValue)
        let currentMinute = calendar.component(.minute, from: date.wrappedValue)

        // Sets h or m based on given param
        date.wrappedValue = calendar.date(
            bySettingHour: hour ?? currentHour,
            minute: minute ?? currentMinute,
            second: 0,
            of: date.wrappedValue
        ) ?? date.wrappedValue
    }
}

#Preview {
    BookDetailsView(session: nil)
        .environment(BookingController())
        
}
