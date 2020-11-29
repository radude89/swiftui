//
//  HistoryView.swift
//  RollDice
//
//  Created by Radu Dan on 28.11.2020.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var rolledEntries: RolledEntries
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rolledEntries.rolls.sorted {
                    $0.timestamp > $1.timestamp
                }) { roll in
                    VStack(alignment: .leading) {
                        Text(formattedRolls(roll.entries))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        Text("Sum is \(totalRolled(from: roll.entries))")
                            .font(.headline)
                            .foregroundColor(.orange)
                        
                        HStack {
                            Text("Time you rolled")
                            
                            Spacer()
                            
                            Text("\(roll.formattedDate)")
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text(rollsAccessibilityValue(roll)))
                }
                .padding()
            }
            .navigationBarTitle("Previous Rolls")
        }
    }
    
    private func formattedRolls(_ rolls: [Int]) -> String {
        rolls.map { "\($0)" }.joined(separator: " ")
    }
    
    private func totalRolled(from rolls: [Int]) -> Int {
        rolls.reduce(0, +)
    }
    
    private func rollsAccessibilityValue(_ roll: RolledEntry) -> String {
        """
        You rolled \(formattedRolls(roll.entries)).
        Total sum of the dice is \(totalRolled(from: roll.entries))
        Date you rolled is \(roll.formattedDate)
        """
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
