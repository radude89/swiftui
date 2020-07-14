//
//  RectangleDrag.swift
//  Animations
//
//  Created by Radu Dan on 14/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct RectangleDrag: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount),
                          axis: (x: 0, y: 1, z: 0))
    }
}

struct RectangleDrag_Previews: PreviewProvider {
    static var previews: some View {
        RectangleDrag()
    }
}
