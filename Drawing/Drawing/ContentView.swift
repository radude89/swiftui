//
//  ContentView.swift
//  Drawing
//
//  Created by Radu Dan on 29/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [self.color(for: value, brightness: 1), self.color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                
            }
        }
        .drawingGroup()
    }
    
    private func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
