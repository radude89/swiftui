//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Radu Dan on 13/05/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // rock = 0
    // paper = 1
    // scissors = 2
    private let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertDescription = ""
    @State private var round = 0
    
    private let maximumRounds = 10
    
    var body: some View {
        VStack {
            if round == maximumRounds {
                Text("Game over!")
                    .font(Font.system(.title))
                    .foregroundColor(Color.red)
                    .padding()
                Button("Load new game") {
                    self.loadNewGame()
                }
            } else {
                Text("Your score is: \(score)")
                ForEach(0 ..< moves.count) { index in
                    Button(self.moves[index]) {
                        self.userSelectedMove(at: index)
                    }
                }
                .padding()
                Text("You should \(shouldWin ? "win" : "loose")!")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle),
                  message: Text(alertDescription),
                  dismissButton: .default(Text("Continue")) {
                    self.loadNextRound()
                })
        }
        
    }
    
    private func userSelectedMove(at index: Int) {
        let userMoveIndex = index
        let computerMoveIndex = Int.random(in: 0..<moves.count)
        
        if userMoveIndex == computerMoveIndex {
            alertTitle = "It's a tie!"
            alertDescription = "You both selected \(moves[computerMoveIndex])."
        } else {
            var userWon = (userMoveIndex - computerMoveIndex + 3) % 3 == 1
            userWon = shouldWin ? userWon : !userWon
            
            alertTitle = "You \(userWon ? "won" : "lost") this round"
            alertDescription = "You selected: \(moves[userMoveIndex]).\nComputer selected \(moves[computerMoveIndex])."
            
            if userWon {
                incrementScore()
            } else {
                decrementScore()
            }
        }
        
        showAlert = true
    }
    
    private func decrementScore() {
        guard score > 0 else {
            return
        }
        
        score -= 1
    }
    
    private func incrementScore() {
        score += 1
    }
    
    private func loadNextRound() {
        shouldWin = Bool.random()
        round += 1
    }
    
    private func loadNewGame() {
        score = 0
        round = 0
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
