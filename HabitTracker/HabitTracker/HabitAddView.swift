//
//  HabitAddView.swift
//  HabitTracker
//
//  Created by Radu Dan on 04/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct HabitAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    
    @State private var name = ""
    @State private var description = ""
    @State private var repeatedCount = 0
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name (mandatory)", text: $name)
                
                TextField("Description (mandatory)", text: $description)
                
                Stepper("Completed \(repeatedCount) times", onIncrement: {
                    self.repeatedCount += 1
                }, onDecrement: {
                    if self.repeatedCount > 0 {
                        self.repeatedCount -= 1
                    }
                })
            }
            .navigationBarTitle("Add your new habit")
            .navigationBarItems(leading:
                Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                },
                                trailing:
                Button("Save") {
                    if !self.name.isEmpty && !self.description.isEmpty {
                        let habit = Habit(name: self.name,
                                          description: self.description,
                                          repetitionCount: self.repeatedCount)
                        self.habits.items.append(habit)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.showingAlert = true
                    }
            })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Validation failed"),
                          message: Text("Name and description are mandatory for a new habit."),
                          dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct HabitAddView_Previews: PreviewProvider {
    static var previews: some View {
        HabitAddView(habits: Habits())
    }
}
