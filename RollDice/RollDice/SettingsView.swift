//
//  SettingsView.swift
//  RollDice
//
//  Created by Radu Dan on 28.11.2020.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var numberOfDice = 1
    @State private var selectedDiceIndex = 1
    private var diceSides = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Number of dice")
                ) {
                    Stepper(value: $numberOfDice, in: 1...8, step: 1) {
                        Text("Dice count: \(numberOfDice)")
                    }
                    .accessibilityValue(Text("Number of dices \(numberOfDice) out of 8"))
                }
                
                Section(
                    header: Text("Dice sides")
                ) {
                    Picker("Number of sides", selection: $selectedDiceIndex) {
                        ForEach(0 ..< diceSides.count) {
                            Text("\(diceSides[$0]) sides")
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
            .onDisappear(perform: saveSettings)
        }
    }
    
    private func saveSettings() {
        userSettings.numberOfDice = numberOfDice
        userSettings.sidesPerDice = diceSides[selectedDiceIndex]
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
