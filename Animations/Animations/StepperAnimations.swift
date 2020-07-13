//
//  StepperAnimations.swift
//  Animations
//
//  Created by Radu Dan on 13/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct StepperAnimations: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct StepperAnimations_Previews: PreviewProvider {
    static var previews: some View {
        StepperAnimations()
    }
}
