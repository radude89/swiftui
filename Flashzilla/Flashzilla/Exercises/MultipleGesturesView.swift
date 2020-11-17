//
//  MultipleGesturesView.swift
//  Flashzilla
//
//  Created by Radu Dan on 16.11.2020.
//

import SwiftUI

struct MultipleGesturesView: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onTapGesture(count: 2) {
                print("Double Tapped")
            }
            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                print("In progress: \(inProgress)!")
            }) {
                print("Long pressed")
            }
            .rotationEffect(finalAmount + currentAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
                    }
                    .onChanged { angle in
                        finalAmount += currentAmount
                        currentAmount = .degrees(0)
                    }
            )
//            .highPriorityGesture(...)
    }
}

struct MultipleGesturesView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleGesturesView()
    }
}
