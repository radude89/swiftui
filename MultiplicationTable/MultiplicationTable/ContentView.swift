//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Radu Dan on 16/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 5
    @State private var selectedQuestionIndex = 1
    @State private var questionSelections = ["5", "10", "15", "20", "All"]
    
    private static let maximumTable = 12
        
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Up to multiplication table")) {
                    Stepper(value: $multiplicationTable,
                            in: 1...Self.maximumTable,
                            step: 1) {
                        Text("\(multiplicationTable)")
                    }
                }
                
                Section(header: Text("How many questions?")) {
                    Picker("Number of questions",
                           selection: $selectedQuestionIndex) {
                            ForEach(0 ..< questionSelections.count) {
                                Text("\(self.questionSelections[$0])")
                            }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                NavigationLink(
                    destination: GameView(game: game,
                                          questionsCount: game.items.count)
                ) {
                    Text("Start")
                        .foregroundColor(Color.green)
                }
            }
            .navigationBarTitle("Multiplication Game")
        }
    }
    
    private var game: Game {
        GameFactory.makeGame(numberOfQuestions: numberOfQuestions,
                             multiplicationTable: multiplicationTable,
                             maximumTable: Self.maximumTable)
    }
    
    private var numberOfQuestions: Int {
        if selectedQuestionIndex == questionSelections.count - 1 {
            return -1
        } else {
            return Int(questionSelections[selectedQuestionIndex]) ?? 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
