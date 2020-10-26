//
//  ContentView.swift
//  AccessibilityApp
//
//  Created by Radu Dan on 23/10/2020.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
        Stepper(
            "Rate our service: \(rating)/5",
            value: $rating,
            in: 1...5
        )
        .accessibilityValue(Text("\(rating) out of 5"))
    }
    
    private var basicStepepr: some View {
        Slider(value: $estimate, in: 0...50)
            .padding()
            .accessibilityValue(Text("\(Int(estimate))"))
    }
    
    private var combineText: some View {
        VStack {
            Text("Your score is")
            Text("Score")
                .font(.title)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Your score is 1000"))
    }
    
    private var image: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .accessibility(label: Text(labels[selectedPicture]))
            .accessibility(addTraits: .isButton)
            .accessibility(removeTraits: .isImage)
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
