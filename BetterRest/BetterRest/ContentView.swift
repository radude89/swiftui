//
//  ContentView.swift
//  BetterRest
//
//  Created by Radu Dan on 02/06/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    @State private var sleepAmont = 8.0
    @State private var coffeeAmount = 1
    
    private var idealBedtimeFormatted: String {
        let model = SleepCalculator()
        
        let comps = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (comps.hour ?? 0) * 60 * 60
        let minute = (comps.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmont, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        } catch {
            return "-"
        }
    }
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:
                    Text("When do you want to wake up?")
                ) {
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header:
                    Text("Desired amount of sleep")
                ) {
                    Stepper(value: $sleepAmont, in: 4...12, step: 0.25) {
                        Text("\(sleepAmont, specifier: "%g") hours")
                    }
                    .accessibilityValue(formattedSleepAmount)
                }
                
                Section(header:
                    Text("Daily coffee intake")
                ) {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1..<21) { index in
                            if index == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(index) cups")
                            }
                        }
                    }
                }
                
                Section(header:
                    Text("Calculated bedtime")
                ) {
                    Text("Your ideal bedtime is: \(idealBedtimeFormatted)")
                }
            }
            .navigationBarTitle("Better rest")
        }
    }
    
    private var formattedSleepAmount: String {
        guard let formattedAmount = Self.spellOutNumber.string(from: NSNumber(value: sleepAmont)) else {
            return "\(sleepAmont) hours of sleep."
        }
        
        return "\(formattedAmount) hours of sleep."
    }
    
    private static var spellOutNumber: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }()
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
