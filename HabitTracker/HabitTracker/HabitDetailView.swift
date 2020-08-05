//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Radu Dan on 04/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    let habit: Habit
    
    var body: some View {
        Form {
            Section(header: Text("Details".uppercased())) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text("\(habit.name)")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Description")
                    Spacer()
                    Text("\(habit.description)")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Repetition".uppercased())) {
                HStack {
                    Text("Completed")
                    Spacer()
                    Text("\(habit.repetitionCount) times")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationBarTitle(Text(habit.name), displayMode: .inline)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habit: Habit(name: "Sleeping",
                                     description: "I like to sleep."))
    }
}
