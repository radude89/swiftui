//
//  ContentView.swift
//  ArrowChallenge
//
//  Created by Radu Dan on 03/08/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Rectangle: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
                
        path.move(to: CGPoint(x: rect.minX + insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + insetAmount, y: rect.minY))
        
        return path
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
    @State private var insetAmount: CGFloat = 5
    
    var body: some View {
        VStack {
            ColorCyclingRect(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
                .padding()
            
            VStack(spacing: 0) {
                Triangle()
                    .fill(Color.red)
                    .frame(width: 20, height: 20)
                
                Rectangle(insetAmount: insetAmount)
                    .fill(Color.red)
                    .frame(width: 20, height: 100)
                    .onTapGesture {
                        withAnimation {
                            insetAmount = CGFloat.random(in: 1...9)
                        }
                    }
            }
        }
    .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
