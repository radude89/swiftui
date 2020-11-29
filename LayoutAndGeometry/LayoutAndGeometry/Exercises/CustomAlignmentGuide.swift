//
//  CustomAlignmentGuide.swift
//  LayoutAndGeometry
//
//  Created by Radu Dan on 25.11.2020.
//

import SwiftUI

struct CustomAlignmentGuide: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@radude89")
                    .alignmentGuide(.midAccountAndName) {
                        d in d[VerticalAlignment.center]
                    }
                Image("banner")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("Radu Dan")
                    .alignmentGuide(.midAccountAndName) {
                        d in d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
    
}

struct CustomAlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuide()
    }
}
