//
//  CompactSizeView.swift
//  SnowSeeker
//
//  Created by Radu Dan on 29.11.2020.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Radu")
            Text("Country: Romania")
            Text("Pets: Lola, Fifi")
        }
    }
}

struct CompactSizeView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

struct CompactSizeView_Previews: PreviewProvider {
    static var previews: some View {
        CompactSizeView()
    }
}
