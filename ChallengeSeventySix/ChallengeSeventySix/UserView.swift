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
        }
    }
    
    private var userImage: Image {
        user.image ?? Image("DemoUser")
    }
}

struct UserView_Previews: PreviewProvider {
    static let demoUser = User(name: "Demo User", image: UIImage(named: "DemoUser")!)
    
    static var previews: some View {
        UserView(user: demoUser)
    }
}
