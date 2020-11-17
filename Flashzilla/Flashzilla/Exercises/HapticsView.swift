//
//  HapticsView.swift
//  Flashzilla
//
//  Created by Radu Dan on 16.11.2020.
//

import SwiftUI
import CoreHaptics

struct HapticsView: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Hello, world!")
            .onAppear(perform: prepareHaptics)
            .onTapGesture( perform: complexSuccess)
    }
    
    private func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    private func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptics engine: \(error.localizedDescription)")
        }
    }
}

struct HapticsView_Previews: PreviewProvider {
    static var previews: some View {
        HapticsView()
    }
}
