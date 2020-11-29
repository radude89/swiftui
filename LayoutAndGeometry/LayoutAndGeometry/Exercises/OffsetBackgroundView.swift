//
//  OffsetBackgroundView.swift
//  LayoutAndGeometry
//
//  Created by Radu Dan on 25.11.2020.
//

import SwiftUI

struct OffsetBackgroundView: View {
    var body: some View {
        Text("Hello world")
            .offset(x: 100, y: 100)
            .background(Color.red)
    }
}

struct OffsetBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        OffsetBackgroundView()
    }
}
