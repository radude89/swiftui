//
//  RotationScrollView.swift
//  LayoutAndGeometry
//
//  Created by Radu Dan on 25.11.2020.
//

import SwiftUI

struct RotationScrollView: View {
    private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(colors[index % 7])
                            .rotation3DEffect(
                                .degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct RotationScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RotationScrollView()
    }
}
