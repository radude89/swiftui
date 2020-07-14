//
//  Asymmetric.swift
//  Animations
//
//  Created by Radu Dan on 14/07/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct Asymmetric: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct Asymmetric_Previews: PreviewProvider {
    static var previews: some View {
        Asymmetric()
    }
}
