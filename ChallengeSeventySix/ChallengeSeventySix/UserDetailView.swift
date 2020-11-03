//
//  UserDetailView.swift
//  ChallengeSeventySix
//
//  Created by Radu Dan on 02/11/2020.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        Form {
            Section(header: Text("PROFILE")) {
                NavigationLink(
                    destination: UserView(user: user)
                ) {
                    Text("Show profile image")
                }
            }
            
            Section(header: Text("LOCATION")) {
                NavigationLink(
                    destination: LocationView(annotation: user.annotation)
                ) {
                    Text("Show location")
                }
            }
        }.navigationBarTitle("\(user.name)")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: Mocks.demoUser)
    }
}
