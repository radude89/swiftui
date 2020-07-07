//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Radu Dan on 11/05/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    var titleStyle: some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .titleStyle
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
