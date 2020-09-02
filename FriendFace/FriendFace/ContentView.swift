//
//  ContentView.swift
//  FriendFace
//
//  Created by Radu Dan on 01/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI

// MARK: - Content
struct ContentView: View {
    
    @State private var users = [User]()
    private let dataLoader = DataLoader()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(
                    destination: UserDetailView(
                        user: user,
                        allUsers: self.users,
                        name: nil
                    )
                ) {
                    UserView(user: user)
                }
            }
            .navigationBarTitle("Friend Face")
        }
        .onAppear(perform: fetchUsers)
    }
    
    private func fetchUsers() {
        dataLoader.fetchData { users in
            self.users = users
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - UserView
struct UserView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(self.user.email)
                .font(.headline)
            Text(self.user.company)
                .font(.caption)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User.demoUser)
    }
}
