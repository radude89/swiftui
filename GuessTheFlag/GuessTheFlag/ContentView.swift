//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Radu Dan on 07/05/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let countryName: String
    
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreDescription = ""
    @State private var score = 0
    
    @State private var rotations: [Double] = [0, 0, 0]
    @State private var opacities: [Double] = [1, 1, 1]
    @State private var scales: [CGFloat] = [1, 1, 1]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                    }) {
                        FlagImage(countryName: self.countries[number])
                    }
                    .opacity(self.opacities[number])
                    .rotation3DEffect(.degrees(self.rotations[number]),
                                    axis: (x: 0, y: 1, z: 0))
                    .scaleEffect(self.scales[number])
                    
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreDescription),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        opacities = Array(repeating: 0.25, count: 3)
        scales = Array(repeating: 1, count: 3)
        
        if number == correctAnswer {
            rotations[number] = 360
            opacities[number] = 1
            scoreTitle = "Correct"
            scoreDescription = "Your on fire!"
            incrementScore()
        } else {
            scales[number] = 3
            scoreTitle = "Wrong"
            scoreDescription = "That's the flag of \(countries[number])."
            decrementScore()
        }
        
        showingScore = true
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
        rotations = Array(repeating: 0, count: 3)
        opacities = Array(repeating: 1, count: 3)
        scales = Array(repeating: 1, count: 3)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
