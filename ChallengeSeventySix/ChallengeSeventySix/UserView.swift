//
//  UserView.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 30/10/2020.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                userImage
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width / 0.9)
                
                Text(user.name)
                    .font(.headline)
                    .padding()
            }
        }.navigationBarTitle("Profile Photo")
    }
    
    private var userImage: Image {
        user.image ?? Image("DemoUser")
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: Mocks.demoUser)
    }
}
