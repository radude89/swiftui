//
//  AlignmentGuideView.swift
//  LayoutAndGeometry
//
//  Created by Radu Dan on 25.11.2020.
//

import SwiftUI

struct AlignmentGuideView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello world")
                .alignmentGuide(.leading) { dimension in
                    dimension[.trailing]
                }
            Text("This is a longer text line")
        }
        .background(Color.red)
        .frame(width: 300, height: 300)
        .background(Color.blue)
    }
}

struct AlignmentGuidView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuideView()
    }
}
