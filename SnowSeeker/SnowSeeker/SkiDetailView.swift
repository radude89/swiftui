//
//  SkiDetailView.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

struct SkiDetailView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Elevation: \(resort.elevation)m")
                .layoutPriority(1)
            
            Spacer()
                .frame(height: 0)
            
            Text("Snow: \(resort.snowDepth)cm")
                .layoutPriority(1)
        }
    }
}

struct SkiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailView(resort: Resort.example)
    }
}
