//
//  AllowsHitTestView.swift
//  Flashzilla
//
//  Created by Radu Dan on 16.11.2020.
//

import SwiftUI

struct AllowsHitTestView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped")
                }
            
            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Circle tapped")
                }
                .allowsHitTesting(false)
        }
    }
}

struct AllowsHitTestView_Previews: PreviewProvider {
    static var previews: some View {
        AllowsHitTestView()
    }
}
