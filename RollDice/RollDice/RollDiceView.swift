//
//  RollDiceView.swift
//  RollDice
//
//  Created by Radu Dan on 28.11.2020.
//

import SwiftUI
import CoreHaptics

struct RollDiceView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var rolledEntries: RolledEntries
    
    @State private var diceValues: [Int] = []
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Button("Roll Dice") {
                    rollDice()
                }
                .accessibility(hint: Text("Roll the dice to get a random value"))
                
                VStack {
                    ForEach(diceValues, id: \.self) { value in
                        Text("Dice value is: \(value)")
                            .font(.callout)
                    }
                }
                
                Spacer()
            }.onAppear(perform: prepareHaptics)
        }
    }
    
    private func rollDice() {
        performHapticEvent()
        
        
        diceValues = (0..<userSettings.numberOfDice)
            .map { _ in Int.random(in: 1...userSettings.sidesPerDice) }
        saveDiceValues()
    }
    
    private func saveDiceValues() {
        let rolledEntry = RolledEntry(entries: diceValues)
        rolledEntries.add(rolledEntry)
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptics not supported")
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptics engine: \(error.localizedDescription)")
        }
    }
    
    private func performHapticEvent() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        
        let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
        let end = CHHapticParameterCurve.ControlPoint(relativeTime: 2, value: 0)
        
        let parameter = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [start, end], relativeTime: 0)
        
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 2)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: [parameter])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
