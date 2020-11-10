//
//  ImageInterpolationView.swift
//  HotProspects
//
//  Created by Radu Dan on 10/11/2020.
//

import SwiftUI

struct ImageInterpolationView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInterpolationView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolationView()
    }
}
