//
//  EditCardView.swift
//  Flashzilla
//
//  Created by Radu Dan on 23.11.2020.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new card")) {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationBarTitle("Edit Cards")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
            .onAppear(perform: loadData)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else {
            return
        }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }
    
    private func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func loadData() {
        guard let data = UserDefaults.standard.data(forKey: "Cards"),
              let decoded = try? JSONDecoder().decode([Card].self, from: data) else {
            return
        }
        
        cards = decoded
    }
    
    private func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView()
    }
}
