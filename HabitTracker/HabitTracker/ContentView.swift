//
//  ContentView.swift
//  HabitTracker
//
//  Created by Radu Dan on 04/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    NavigationLink(destination: HabitDetailView(habit: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                            }
                            
                            Spacer()
                            
                            Text("Perfomed \(item.repetitionCount) times")
                                .font(.callout)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),
                                trailing:
                Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddHabit) {
                HabitAddView(habits: self.habits)
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
