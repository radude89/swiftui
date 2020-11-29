//
//  SplitExampleView.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

struct SplitExampleView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                Text("Hello, world!")
                    .padding()
            }
            .navigationBarTitle("Primary")
            
            Text("Secondary")
        }
    }
}

struct SplitExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SplitExampleView()
    }
}
