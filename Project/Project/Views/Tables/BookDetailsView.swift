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
    
    // The "Easy" constructor for 11 AM
    func setTime(hour: Int, minute: Int) -> Date {
        Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
    }
}

func DateComp (date: Date, component: Calendar.Component) -> Int {
    return Calendar.current.component(component, from: date);
}

func SkipValid() -> Date {
    var hour = Calendar.current.component(.hour, from: Date.now);
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
    let serifFont: Font = .system(size: 20, design: .serif).bold();
    let control = BookingController();
    
    @State var dateSelect: Bool = true;
    @State var numPeople = 1;
    @State var date: Date  = Date.tomorrow.setTime(hour: 11, minute: 0);
    
    // HH:MM variable modifications
    var hourBinding: Binding<Int> {
        Binding(
            get: {
                Calendar.current.component(.hour, from: date)
            },
            set: { newHour in
                date = Calendar.current.date(
                    bySettingHour: newHour,
                    minute: Calendar.current.component(.minute, from: date),
                    second: 0,
                    of: date
                ) ?? date
            }
        )
    }
    
    var minuteBinding: Binding<Int> {
        Binding(
            get: {
                Calendar.current.component(.minute, from: date)
            },
            // Forces date to be after now
            set: { newMinute in
                date = Calendar.current.date(
                        bySettingHour: Calendar.current.component(.hour, from: date),
                        minute: newMinute,
                        second: 0,
                        of: date
                ) ?? date
            }
        )
    }
    
    // Date related components
    let name = "Marcus"
    let today = Calendar.current.startOfDay(for: Date())
    let upLimitDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())!
    
    init() {
        
    }
    
    var body: some View {
        VStack(spacing: 15) {
            // Text("Booking for \(name)").font(serifFont);
            
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
            
            if (dateSelect) {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    in: today...upLimitDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .tint(.blue).bold()
                .onChange(of: date) { _, newValue in
                    if (date < SkipValid()) {
                        date = SkipValid();
                    }
                }
            }
            else {
                if Calendar.current.isDateInToday(date) {
                    Text("Today").font(serifFont).foregroundStyle(.blue);
                } else if Calendar.current.isDateInTomorrow(date) {
                    Text("Tomorrow").font(serifFont).foregroundStyle(.blue);
                }
                else {
                    Text(date.formatted(.dateTime.weekday(.wide).day().month(.wide))).font(serifFont).foregroundStyle(.blue);
                }
            }
            
            Text("Time").font(serifFont);
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
              
            Text("Table For: \(self.numPeople)").font(serifFont);
            Slider(
                value: Binding(
                    get: { Double(self.numPeople) },
                    set: { self.numPeople = Int($0) }
                ),
                in: 1...10,
                step: 1
            )
            
            Button {
                print("Hello")
            } label: {
                Text("Proceed to Booking").font(serifFont)
                    .frame(maxWidth: .infinity)
                    .padding()
            }.buttonStyle(PrimaryButtonStyle())
            
        }.padding(15)
    }

}

#Preview {
    BookDetailsView()
}
