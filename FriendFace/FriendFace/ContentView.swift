//
//  ContentView.swift
//  FriendFace
//
//  Created by Radu Dan on 01/09/2020.
//  Copyright © 2020 Radu Dan. All rights reserved.
//

import SwiftUI
import CoreData

// MARK: - ContentView
struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: UserC.entity(), sortDescriptors: []) var users: FetchedResults<UserC>
    
    private let dataLoader = DataLoader()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(
                    destination: UserDetailView(
                        user: user,
                        allUsers: self.users
                    )
                ) {
                    UserView(user: user)
                }
            }
            .navigationBarTitle("Friend Face")
        }
        .onAppear(perform: loadUsers)
    }
    
    private func loadUsers() {
        if users.isEmpty {
            fetchUsersFromNetwork()
        }
    }
    
    private func fetchUsersFromNetwork() {
        dataLoader.fetchData { users in
            users.forEach { fetchedUser in
                _ = UserC(context: self.moc, user: fetchedUser)
                try? self.moc.save()
            }
        }
    }
}

// MARK: - UserView
struct UserView: View {
    var user: UserC
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(self.user.wrappedEmail)
                .font(.headline)
            Text(self.user.wrappedCompany)
                .font(.caption)
        }
    }
}

// MARK: - Previews
struct UserView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let user = UserC(context: moc, user: User.demoUser)
        return UserView(user: user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
