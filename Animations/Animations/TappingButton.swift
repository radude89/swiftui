//
//  TappingButton.swift
//  Animations
//
//  Created by Radu Dan on 13/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct TappingButton: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap me") {
            
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true)
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

struct TappingButton_Previews: PreviewProvider {
    static var previews: some View {
        TappingButton()
    }
}
