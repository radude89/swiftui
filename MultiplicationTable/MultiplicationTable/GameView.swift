//
//  GameView.swift
//  MultiplicationTable
//
//  Created by Radu Dan on 16/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var game: Game
    @State var questionsCount: Int
    
    @State private var score = 0
    
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var scoreDescription = ""
    
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var gameFinished = false
    
    @State private var questionIndex = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.green, .blue]),
                startPoint: .top,
                endPoint: .bottom
            )
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text(game.items[correctAnswer].question)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                ForEach(0 ..< 4) { index in
                    Button(action: {
                        self.answerTapped(at: index)
                    }) {
                        AnswerView(answerNumber:
                            self.game.items[index].answer)
                    }
                }
                
                VStack {
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                    Text("Remaining questions: \(questionsCount)")
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreDescription),
                  dismissButton: .default(Text("Continue")) {
                    if self.gameFinished {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.askQuestion()
                    }
                })
        }
    }
    
    private func answerTapped(at index: Int) {
        
        if index == correctAnswer {
            scoreTitle = "Correct"
            scoreDescription = "Your on fire!"
            incrementScore()
        } else {
            scoreTitle = "Wrong"
            scoreDescription = "That's incorrect."
            decrementScore()
        }
        
        questionIndex += 1
        
        if questionIndex == game.items.count - 1 {
            gameFinished = true
            scoreTitle = "Game over"
            scoreDescription = "Your total score is: \(score)!"
        }
        
        showingAlert = true
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
    
    func askQuestion() {
        game.items.shuffle()
        correctAnswer = Int.random(in: 0...3)
        questionsCount -= 1
    }
}

struct AnswerView: View {
    let answerNumber: String
    
    var body: some View {
        Text("\(answerNumber)")
            .foregroundColor(Color.white)
            .frame(width: 50, height: 50, alignment: .center)
            .font(.largeTitle)
            .padding()
            .overlay(Circle()
                .stroke(Color.white, lineWidth: 4)
                .padding(6))
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameFactory.makeGame(numberOfQuestions: 10,
                                        multiplicationTable: 5,
                                        maximumTable: 12)
        return GameView(game: game, questionsCount: game.items.count)
    }
}
