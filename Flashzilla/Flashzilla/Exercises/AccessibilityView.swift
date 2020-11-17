//
//  AccessibilityView.swift
//  Flashzilla
//
//  Created by Radu Dan on 17.11.2020.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct AccessibilityView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State private var scale: CGFloat = 1
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            Text("Hello World")
                .scaleEffect(scale)
                .onTapGesture {
                    if reduceMotion {
                        scale += 1.5
                    } else {
                        withOptionalAnimation {
                            scale *= 1.5
                        }
                    }
                }
            
            Text("2")
                .padding()
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}

struct AccessibilityView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityView()
    }
}
