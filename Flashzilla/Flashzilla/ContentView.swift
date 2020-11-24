//
//  ContentView.swift
//  Flashzilla
//
//  Created by Radu Dan on 16.11.2020.
//

import SwiftUI
import CoreHaptics

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    private enum SheetType {
        case edit
        case settings
        case none
    }
    
    @State private var cards: [Card] = []
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingSheet = false
    @State private var sheetType: SheetType = .none
    @State private var showingTimeRunOut = false
    @State private var cardBackToDeck = false
    @State private var engine: CHHapticEngine?
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) { result in
                            withAnimation {
                                removeCard(at: index, successfulAnswer: result)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibility(hidden: index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if !isActive && cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack(spacing: 20) {
                    Spacer()
                    
                    Button(action: {
                        sheetType = .edit
                        showingSheet = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        sheetType = .settings
                        showingSheet = true
                    }) {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if showingTimeRunOut {
                VStack {
                    Text("Time run out!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.green)
                                .opacity(0.75)
                        )
                        .onAppear(perform: performHaptics)
                    
                    Spacer()
                }
            }
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                removeCard(at: cards.count - 1, successfulAnswer: false)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibilityHint(Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        
                        Button(action : {
                            withAnimation {
                                removeCard(at: cards.count - 1, successfulAnswer: true)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibilityHint(Text("Mark your answer as being correct."))
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                showingTimeRunOut = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if cards.isEmpty == false {
                isActive = true
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            switch sheetType {
            case .settings:
                SettingsView(cardBackToDeck: $cardBackToDeck)
                
            case .edit:
                EditCardView()
                
            default:
                EmptyView()
            }
        }
        .onAppear(perform: resetCards)
    }
    
    private func removeCard(at index: Int, successfulAnswer: Bool) {
        guard index >= 0 else {
            return
        }
        
        let card = cards.remove(at: index)
        
        if cardBackToDeck && successfulAnswer == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {
                cards.insert(card, at: 0)
            }
        } else if cards.isEmpty {
            isActive = false
        }
    }
    
    private func resetCards() {
        cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
        showingTimeRunOut = false
        loadData()
    }
    
    private func loadData() {
        guard let data = UserDefaults.standard.data(forKey: "Cards"), let decoded = try? JSONDecoder().decode([Card].self, from: data) else {
            return
        }
        
        cards = decoded
    }
    
    private func performHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        loadHapticsEngine()
        
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
        
        resetCards()
    }
    
    private func loadHapticsEngine() {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1024, height: 768))
    }
}
