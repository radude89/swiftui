//
//  ContentView.swift
//  WorldScrabble
//
//  Created by Radu Dan on 08/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word",
                          text: $newWord,
                          onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("\(word), \(word.count) letters"))
                }
                
                Text("Score: \(score)")
                    .padding()
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: generateStartingWord)
            .navigationBarItems(leading: Button("New Word") {
                self.generateStartingWord()
            }, trailing: Button("New Game") {
                self.restartGame()
            })
            .alert(isPresented: $showingError) { () -> Alert in
                Alert(title: Text(errorTitle),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        guard hasEnoughCharacters(word: answer) else {
            wordError(title: "Too short", message: "You need at least four letters")
            return
        }
        
        guard !isPrefix(word: answer) else {
            wordError(title: "Prefixes are not allowed", message: "You need to think of another way")
            return
        }
        
        calculateScore()
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    private let allWords: [String] = {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL) else {
                fatalError("Could not load start.txt from Bundle")
        }
        
        return startWords.components(separatedBy: "\n")
    }()
    
    private func generateStartingWord() {
        rootWord = allWords.randomElement() ?? "silkworm"
    }
    
    private func restartGame() {
        score = 0
        newWord = ""
        usedWords = []
        
        generateStartingWord()
    }
    
    private func calculateScore() {
        score += newWord.count + 1
    }
    
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func hasEnoughCharacters(word: String) -> Bool {
        word.count > 3
    }
    
    private func isPrefix(word: String) -> Bool {
        rootWord.hasPrefix(word)
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
